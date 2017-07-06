$baseURL = "https://cdn02.brighttalk.com/core/asset/video/258397/ios/iphone/video_1498156414-4_*.ts"

# WHERE * is a number e.g. 00001

# NOTE :- It's the # that is replaced

$folder = "C:\TSThief"

$userAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20100101 Firefox/7.0.1"
$web = New-Object System.Net.WebClient
$web.Headers.Add("user-agent", $userAgent)

$blnHit404 = $false

$i = 1

$target = ""

do
{
        
    #$magicnumber = [string]$baseURL.Replace("*", $i)
    
    $magicnumber = $i.toString()
    
    $pad = 4 - $magicnumber.length
    for ($j=0;  $j -le $pad; $j++)
    {
      $magicnumber = "0" + $magicnumber
    }
    
    $URL = [string]$baseURL.Replace("*", $magicnumber)
    
    $target = $folder + "\" + $magicnumber + ".ts"
    
    try {
            Write-Host $URL
            $web.DownloadFile($URL, $target)
        } catch {
            $_.Exception.Message
            if ($_.Exception.Message.Contains("404") -eq $true)
            {
                $blnHit404 = $true
            }
            
        }


    $i++

} while($blnHit404 -eq $false -AND $i -le 99999 )    # 99999 is the magic pad these needs


# Now all I did was
# copy /b *.ts output.file
# del *.ts
# rename output.file as output.ts
# Use Handbrake against output.ts   (takes a 651MB file down to )

