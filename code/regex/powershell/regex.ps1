$r1 = ""
$r2 = ""
for($i = 0; $i -lt 29; $i++) {
    $r1 += "a?"
    $r2 += "a"
    $r = $r1 + $r2
    if($r2 -match $r) {
        Write-Host "$r2 matches $r"
    } else {
        Write-Host "matching failure"
    }
}