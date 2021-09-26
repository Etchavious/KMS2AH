# Files for Ingestion
$xmlFileKR = $pwd.path + "\" + "itemname-kr.xml"
$xmlFileEN = $pwd.path + "\" + "itemname-en.xml"

# Initialize XML Documents
$xmlDocKR = New-Object System.Xml.XmlDocument
$xmlDocKR.Load($xmlFileKR)
$xmlDocEN = New-Object System.Xml.XmlDocument
$xmlDocEN.Load($xmlFileEN)

# Initialize Merger Table
$mergeTable = New-Object System.Data.DataTable
$newCol = New-Object System.Data.DataColumn "ID",([string])
$mergeTable.Columns.Add($newCol)
$mergeTable.PrimaryKey = $newCol
$newCol = New-Object System.Data.DataColumn "Name_KR",([string])
$mergeTable.Columns.Add($newCol)
$newCol = New-Object System.Data.DataColumn "Name_EN",([string])
$mergeTable.Columns.Add($newCol)

# Create the Merge Table from KR Source
foreach ($key in $xmlDocKR.ms2.key) {
    $newRow = $mergeTable.NewRow()
    $newRow.ID = $key.ID.Trim()
    $newRow.Name_KR = $key.Name.Trim()
    $mergeTable.Rows.Add($newRow)
}

# Populate English Values
$endCount = $xmlDocKR.ms2.key.count
$currentCount = 1

foreach ($key in $xmlDocEN.ms2.key) {
    $countPercent = ($currentCount / $endCount) * 100
    $countStatus = $currentCount.ToString() + "/" + $endCount.ToString()
    Write-Progress -Activity "Populating English Data" -Status "Progress -> $countStatus" -PercentComplete $countPercent
    
    $selectString = "[ID] = '" + $key.ID + "'"
    $thisTable = $mergeTable.Select($selectString)
    $thisTable[0].Name_EN = $key.Name.Trim()    	

    $currentCount += 1
}

# Output to JSON File / Database
$mergeTable | Select $mergeTable.Columns.Columnname | ConvertTo-Json | Out-File itemdatabase.json