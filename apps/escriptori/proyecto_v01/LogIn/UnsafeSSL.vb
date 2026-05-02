Imports System.Net.Http
Imports System.Net.Security
Imports System.Security.Cryptography.X509Certificates
Imports Org.BouncyCastle.X509

Public Module UnsafeSSL
    Public Function createUnsafeClient() As HttpClient
        Dim handler As New HttpClientHandler()
        handler.ServerCertificateCustomValidationCallback =
            Function(sender As HttpRequestMessage,
                     cert As X509Certificate2,
                     chain As X509Chain,
                     sslPolicyErrors As SslPolicyErrors)
                Return True
            End Function
        Return New HttpClient(handler)
    End Function
End Module
