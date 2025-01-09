#!ps1
# 
# JournalList.net website scraper using WordPress plugin
#
# Usage: sitescrape.ps1 [URL | LIST.csv]
# URL - the URL of the website for which to generate a TRUST.txt file
# LIST.csv - a list of URLs of websites for which to generate TRUST.txt files 
#----
# If argument is a file then process a list the list of URLs
#
if (Test-Path -Path $args[0]) {
    $urls = Get-Content -Path $args[0]
    $dir = $args[0].Split("/")[0]
} else {
    $urls = $args[0]
    $dir = "."
}
foreach ($url in $urls) {
$data = @"
{"url": "$url"}
"@
    $type = "Content-Type: application/json"
    $domain = $url.replace('https://','').replace('http://','').replace('/','')
    $filename = $domain
    $temp = "./temp.json"
    Write-Host "Processing: " $url
    curl -X POST https://journallist.net/wp-json/trust-txt/v1/generate -H "$type" -d "$data" | ConvertFrom-Json | Out-File -FilePath $temp
    (Get-Content $temp) -replace ',$', '' | Set-Content $temp
    (Get-Content $temp) -replace '"', '' | Set-Content $temp
    (Get-Content $temp) -replace '^  ', '' | Set-Content $temp
    Copy-Item $temp -Destination $dir/$filename"-trust.txt"
    Remove-Item ./temp.json
}