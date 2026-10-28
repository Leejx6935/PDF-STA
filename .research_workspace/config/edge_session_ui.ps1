param(
    [ValidateSet('Inspect','Navigate','Invoke','Save','Screenshot')][string]$Action = 'Inspect',
    [string]$Url,
    [string]$Name,
    [string]$SavePath,
    [string]$EvidenceName = 'edge_session'
)
$ErrorActionPreference = 'Stop'
$OutputEncoding = [Console]::OutputEncoding = New-Object System.Text.UTF8Encoding
Add-Type -AssemblyName UIAutomationClient
Add-Type -AssemblyName UIAutomationTypes
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type @'
using System;
using System.Runtime.InteropServices;
public static class ResearchEdgeWindow {
 [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
 [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
 [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd,int nCmdShow);
 [DllImport("user32.dll")] public static extern bool IsIconic(IntPtr hWnd);
 [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd,out RECT r);
 public struct RECT { public int Left,Top,Right,Bottom; }
}
'@
$edgeWindow = Get-Process msedge -ErrorAction Stop | Where-Object { $_.MainWindowHandle -ne 0 } | Select-Object -First 1
if (-not $edgeWindow) { throw 'No existing Edge window was found.' }
$handle = $edgeWindow.MainWindowHandle
$root = [System.Windows.Automation.AutomationElement]::FromHandle($handle)
if ($Action -ne 'Inspect') {
    if ([ResearchEdgeWindow]::IsIconic($handle)) { [ResearchEdgeWindow]::ShowWindow($handle,9) | Out-Null }
    [ResearchEdgeWindow]::SetForegroundWindow($handle) | Out-Null
    Start-Sleep -Milliseconds 350
}
if ($Action -eq 'Navigate') {
    $targetUri = [uri]$Url
    if ($targetUri.Scheme -ne 'https' -or $targetUri.Host -notmatch '(^|\.)(sciencedirect\.com|ieeexplore\.ieee\.org|cris\.unibo\.it)$') { throw 'Navigation is limited to the research publisher/repository sites.' }
    Start-Process -FilePath $edgeWindow.Path -ArgumentList @('--new-tab',$targetUri.AbsoluteUri) | Out-Null
    Start-Sleep -Seconds 5
}
if ($Action -eq 'Screenshot') {
    $captureDir=Join-Path $PSScriptRoot '..\tasks\T018_edge_download_probe'
    New-Item -ItemType Directory -Path $captureDir -Force | Out-Null
    $rect=New-Object ResearchEdgeWindow+RECT
    [ResearchEdgeWindow]::GetWindowRect($handle,[ref]$rect) | Out-Null
    $width=$rect.Right-$rect.Left; $height=$rect.Bottom-$rect.Top
    $bitmap=New-Object System.Drawing.Bitmap($width,$height)
    $graphics=[System.Drawing.Graphics]::FromImage($bitmap)
    $graphics.CopyFromScreen($rect.Left,$rect.Top,0,0,$bitmap.Size)
    $imagePath=Join-Path $captureDir ($EvidenceName+'.png')
    $bitmap.Save($imagePath,[System.Drawing.Imaging.ImageFormat]::Png)
    $graphics.Dispose(); $bitmap.Dispose()
    [pscustomobject]@{screenshot=$imagePath} | ConvertTo-Json
    exit
}
if ($Action -eq 'Invoke') {
    if (-not $Name) { throw 'An exact observed UI name is required.' }
    $condition = New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::NameProperty,$Name)
    $matches = $root.FindAll([System.Windows.Automation.TreeScope]::Descendants,$condition)
    $invoked = $false
    foreach ($match in $matches) {
        $pattern = $null
        if ($match.TryGetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern,[ref]$pattern)) { $pattern.Invoke(); $invoked=$true; break }
        if ($match.TryGetCurrentPattern([System.Windows.Automation.SelectionItemPattern]::Pattern,[ref]$pattern)) { $pattern.Select(); $invoked=$true; break }
    }
    if (-not $invoked) { throw 'No matching invokable UI element found.' }
    Start-Sleep -Seconds 4
}
if ($Action -eq 'Save') {
    if ([ResearchEdgeWindow]::GetForegroundWindow() -ne $handle) { throw 'Edge did not obtain foreground focus; no save shortcut was sent.' }
    if (-not $SavePath) { throw 'SavePath is required.' }
    $resolved = [System.IO.Path]::GetFullPath($SavePath)
    $allowedRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\inputs\four_papers'))
    if (-not $resolved.StartsWith($allowedRoot + [System.IO.Path]::DirectorySeparatorChar,[System.StringComparison]::OrdinalIgnoreCase)) { throw 'Save target must be in the research input folder.' }
    if (Test-Path -LiteralPath $resolved) { throw 'Target exists; do not overwrite source papers.' }
    $addressCondition=New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::NameProperty,'地址和搜索栏')
    $address=$root.FindFirst([System.Windows.Automation.TreeScope]::Descendants,$addressCondition)
    $addressValue=[string]$address.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).Current.Value
    if ($addressValue -notmatch '^https://[^/]*(sciencedirectassets\.com|sciencedirect\.com|ieeexplore\.ieee\.org)/') { throw 'Current tab is not an allowed publisher PDF location.' }
    $challengeCondition=New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::NameProperty,'请验证您是真人')
    if ($root.FindFirst([System.Windows.Automation.TreeScope]::Descendants,$challengeCondition)) { throw 'Human verification is still pending; do not save the challenge page.' }
    $buttonCondition=New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::ControlTypeProperty,[System.Windows.Automation.ControlType]::Button)
    $pageButtons=$root.FindAll([System.Windows.Automation.TreeScope]::Descendants,$buttonCondition)
    $pdfSaveVisible=$false
    foreach ($pageButton in $pageButtons) { if ($pageButton.Current.Name -match '^(保存|保存文件|另存为|Save|Save file|Save as)(\s*\(.*\))?$') { $pdfSaveVisible=$true; break } }
    if (-not $pdfSaveVisible) { throw 'A PDF viewer save control is not present. The tab may still be loading or require human verification.' }
    [System.Windows.Forms.SendKeys]::SendWait('^s')
    Start-Sleep -Seconds 2
    $desktop = [System.Windows.Automation.AutomationElement]::RootElement
    $dialogCondition = New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::ControlTypeProperty,[System.Windows.Automation.ControlType]::Window)
    $windows = $desktop.FindAll([System.Windows.Automation.TreeScope]::Children,$dialogCondition)
    $saveDialog = $null
    foreach ($win in $windows) { if ($win.Current.Name -match '另存为|Save As') { $saveDialog=$win; break } }
    if (-not $saveDialog) { throw 'Save As dialog was not detected; no path was entered.' }
    $edits=$saveDialog.FindAll([System.Windows.Automation.TreeScope]::Descendants,(New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::ControlTypeProperty,[System.Windows.Automation.ControlType]::Edit)))
    $fileEdit=$null
    foreach ($edit in $edits) { if ($edit.Current.Name -match '文件名|File.name' -or $edit.Current.AutomationId -eq '1001') { $fileEdit=$edit; break } }
    if (-not $fileEdit) { throw 'Filename field was not identified; no filename was entered.' }
    $fileEdit.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).SetValue($resolved)
    $saveButton=$saveDialog.FindFirst([System.Windows.Automation.TreeScope]::Descendants,(New-Object System.Windows.Automation.PropertyCondition([System.Windows.Automation.AutomationElement]::AutomationIdProperty,'1')))
    if (-not $saveButton -or $saveButton.Current.Name -notmatch '保存|Save') { throw 'Save button was not identified; filename is entered but not committed.' }
    $saveButton.GetCurrentPattern([System.Windows.Automation.InvokePattern]::Pattern).Invoke()
    Start-Sleep -Seconds 3
}
$root = [System.Windows.Automation.AutomationElement]::FromHandle($handle)
$walker = [System.Windows.Automation.TreeWalker]::ControlViewWalker
$queue = New-Object System.Collections.Queue
$queue.Enqueue([pscustomobject]@{Element=$root;Depth=0})
$rows = New-Object System.Collections.Generic.List[object]
$visited = 0
while ($queue.Count -gt 0 -and $visited -lt 1800) {
    $pair = $queue.Dequeue(); $element=$pair.Element; $depth=[int]$pair.Depth; $visited++
    try {
        $current=$element.Current
        $label=$current.Name
        if ($label -and $label.Length -gt 220) { $label=$label.Substring(0,220) }
        $value=$null
        if ($current.ControlType -eq [System.Windows.Automation.ControlType]::Edit -and ($current.AutomationId -match 'address|url|omnibox' -or $label -eq '地址和搜索栏')) {
            try {
                $rawAddress=[string]$element.GetCurrentPattern([System.Windows.Automation.ValuePattern]::Pattern).Current.Value
                $addressUri=[uri]$rawAddress
                if ($addressUri.IsAbsoluteUri) { $value=$addressUri.GetLeftPart([System.UriPartial]::Path) }
            } catch { }
        }
        if ($label -or $value) { $rows.Add([pscustomobject]@{depth=$depth;type=$current.ControlType.ProgrammaticName;name=$label;automation_id=$current.AutomationId;value=$value}) }
        if ($depth -lt 15) {
            $child=$walker.GetFirstChild($element)
            while ($child) { $queue.Enqueue([pscustomobject]@{Element=$child;Depth=($depth+1)}); $child=$walker.GetNextSibling($child) }
        }
    } catch { }
}
$evidenceDir = Join-Path $PSScriptRoot '..\tasks\T018_edge_download_probe'
New-Item -ItemType Directory -Path $evidenceDir -Force | Out-Null
$output=[pscustomobject]@{action=$Action;window_title=$edgeWindow.MainWindowTitle;visited=$visited;elements=$rows}
$output | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath (Join-Path $evidenceDir ($EvidenceName+'.json')) -Encoding UTF8
$summary = @($rows | Where-Object { $_.type -eq 'ControlType.Document' -or $_.type -eq 'ControlType.Edit' -or ($_.type -match 'Button|Hyperlink|TabItem' -and $_.name -match 'PDF|Download|View|Access|Institution|Purchase|Full.text|Get.access|另存|保存|下载|登录|Sign.in|ScienceDirect|IEEE|Finite.time|Command.filter|reinforcement|Disturbance.observer') })
[pscustomobject]@{action=$Action;evidence_file=(Join-Path $evidenceDir ($EvidenceName+'.json'));window_title=$edgeWindow.MainWindowTitle;visited=$visited;controls=$summary} | ConvertTo-Json -Depth 5
