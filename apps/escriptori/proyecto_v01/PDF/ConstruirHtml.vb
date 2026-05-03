Imports PuppeteerSharp
Imports PuppeteerSharp.Media
''' <summary>
''' convertir html a pdf
''' </summary>
Public Class ConstruirHtml

    Public Shared Async Function htmlToPdfAsync(html As String) As Task(Of Byte())
        Dim browserFetch As New BrowserFetcher()
        Await browserFetch.DownloadAsync()

        Using browser As IBrowser = Await Puppeteer.LaunchAsync(
        New LaunchOptions With {
        .Headless = True,
        .Args = {"--no-sandbox", "--disable-setuid-sandbox"}
        })

            Using page As IPage = Await browser.NewPageAsync()
                Await page.SetContentAsync(html, New NavigationOptions With {
                                           .WaitUntil = {WaitUntilNavigation.Networkidle0}
                                           })

                Dim pdfOptions As New PdfOptions With {
                    .Format = PaperFormat.A4,
                    .PrintBackground = True,
                    .MarginOptions = New MarginOptions With {
                    .Top = "15mm",
                    .Bottom = "15mm",
                    .Left = "15mm",
                    .Right = "15mm"
                }}

                Return Await page.PdfDataAsync(pdfOptions)
            End Using
        End Using
    End Function
End Class
