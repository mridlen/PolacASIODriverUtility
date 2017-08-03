$polac_asio_interfaces = Get-ChildItem "hklm:\software\asio\" -Recurse | ?{ $_.PSIsContainer } | Select-Object -ExpandProperty pschildname

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form 
$form.Text = "Polac ASIO Driver"
$form.Size = New-Object System.Drawing.Size(300,200) 
$form.StartPosition = "CenterScreen"

$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Point(75,120)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $OKButton
$form.Controls.Add($OKButton)

$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Point(150,120)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $CancelButton
$form.Controls.Add($CancelButton)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20) 
$label.Size = New-Object System.Drawing.Size(280,20) 
$label.Text = "Which audio driver would you like to use?"
$form.Controls.Add($label) 

$listBox = New-Object System.Windows.Forms.ComboBox 
$listBox.Location = New-Object System.Drawing.Point(10,40) 
$listBox.Size = New-Object System.Drawing.Size(260,20) 

#$listBox.SelectionMode = "MultiExtended"

foreach ($i in $polac_asio_interfaces)
{
    [void] $listBox.Items.Add($i)
}

$listBox.Height = 70
$form.Controls.Add($listBox) 
$form.Topmost = $True

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
    #$x = $listBox.SelpoweectedItems
    #$x
    Write-Host $listBox.SelectedItem
    Set-ItemProperty -Path "hkcu:\software\Jeskola\buzz\Polac ASIO" -Name "DriverName" -Value $listBox.SelectedItem
}
