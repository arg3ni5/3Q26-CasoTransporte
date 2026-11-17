Imports System.Security.Cryptography

' Utilidad para guardar contraseñas de forma segura.
' Nunca se guarda la contraseña en texto plano ni con un hash simple (MD5/SHA sin sal).
' Se usa PBKDF2 con SHA-256, una sal aleatoria por usuario y muchas iteraciones.
' Formato guardado en Usuarios.PasswordHash:  iteraciones.salBase64.hashBase64
Public NotInheritable Class PasswordHasher
    Private Const ITERACIONES As Integer = 100000
    Private Const TAMANO_SAL As Integer = 16   ' bytes
    Private Const TAMANO_HASH As Integer = 32  ' bytes

    Private Sub New()
    End Sub

    ' Genera el texto que se guarda en la base de datos
    Public Shared Function Hash(password As String) As String
        Dim sal(TAMANO_SAL - 1) As Byte
        Using rng As New RNGCryptoServiceProvider()
            rng.GetBytes(sal)
        End Using
        Dim hashBytes As Byte() = Derivar(password, sal, ITERACIONES)
        Return ITERACIONES.ToString() & "." & Convert.ToBase64String(sal) & "." & Convert.ToBase64String(hashBytes)
    End Function

    ' Compara la contraseña escrita por el usuario contra el hash guardado
    Public Shared Function Verificar(password As String, hashGuardado As String) As Boolean
        If String.IsNullOrEmpty(password) OrElse String.IsNullOrEmpty(hashGuardado) Then Return False

        Dim partes As String() = hashGuardado.Split("."c)
        If partes.Length <> 3 Then Return False

        Try
            Dim iteraciones As Integer = Integer.Parse(partes(0))
            Dim sal As Byte() = Convert.FromBase64String(partes(1))
            Dim esperado As Byte() = Convert.FromBase64String(partes(2))
            Dim calculado As Byte() = Derivar(password, sal, iteraciones, esperado.Length)
            Return SonIguales(esperado, calculado)
        Catch ex As FormatException
            Return False ' el valor guardado no tiene el formato esperado
        End Try
    End Function

    Private Shared Function Derivar(password As String, sal As Byte(), iteraciones As Integer,
                                    Optional tamano As Integer = TAMANO_HASH) As Byte()
        Using pbkdf2 As New Rfc2898DeriveBytes(password, sal, iteraciones, HashAlgorithmName.SHA256)
            Return pbkdf2.GetBytes(tamano)
        End Using
    End Function

    ' Compara en tiempo constante (no se detiene en el primer byte distinto)
    Private Shared Function SonIguales(a As Byte(), b As Byte()) As Boolean
        If a.Length <> b.Length Then Return False
        Dim diferencia As Integer = 0
        For i As Integer = 0 To a.Length - 1
            diferencia = diferencia Or (a(i) Xor b(i))
        Next
        Return diferencia = 0
    End Function
End Class
