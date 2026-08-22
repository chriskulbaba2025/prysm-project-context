$ErrorActionPreference = "Stop"

$repo = "chriskulbaba2025/prysm-project-context"
$basePath = "PATCHES/render-report-v2-package"
$parts = @()

0..5 | ForEach-Object {
    $name = "part{0:D2}.b64" -f $_
    $apiContent = gh api "repos/$repo/contents/$basePath/$name?ref=main" --jq .content
    if ($LASTEXITCODE -ne 0) { throw "Failed to fetch $name from GitHub." }
    $wrapped = ($apiContent -join "").Replace("`n", "")
    $parts += [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($wrapped))
}

$compressed = [Convert]::FromBase64String(($parts -join ""))
$inputStream = [IO.MemoryStream]::new($compressed)
$gzip = [IO.Compression.GZipStream]::new($inputStream, [IO.Compression.CompressionMode]::Decompress)
$outputStream = [IO.MemoryStream]::new()
$gzip.CopyTo($outputStream)
$gzip.Dispose()
$inputStream.Dispose()

$target = Join-Path (Get-Location).Path "src\report\render-report-v2.js"
$targetDir = Split-Path $target -Parent
if (-not (Test-Path $targetDir)) {
    throw "Expected worker path was not found: $targetDir. Run this script from services\worker."
}

[IO.File]::WriteAllBytes($target, $outputStream.ToArray())
$outputStream.Dispose()

Write-Host "Updated: $target"
Write-Host "Next: node --check src/report/render-report-v2.js"
