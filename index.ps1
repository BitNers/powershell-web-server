$web = New-Object Net.HttpListener
$web.Prefixes.Add("http://+:80/")
$web.Start()

while($web.IsListening){
    $HC = $web.GetContext();
    $HRes = $HC.Response
    $HRes.Headers.Add("Content-Type", "text/html")
    $Buf = [Text.Encoding]::UTF8.GetBytes((GC (Join-Path $Pwd ($HC.Request).RawUrl)))
    $HRes.ContentLength64 = $Buf.Length
    $HRes.OutputStream.Write($Buf, 0, $Buf.length)
    $Hres.Close()
}

$web.Stop();