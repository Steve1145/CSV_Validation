###Place file in D:\NewFile\
$csvfile=Get-ChildItem -Path 'D:\NewFile\' -Force -Recurse
$path=$csvfile.FullName
$fieldnames=Import-Csv -Path $path
$correctcolumns=((Get-Content $path)[0] -split ",").count
$fieldname0=$fieldnames[0].psobject.Properties.name.GetValue(0) 
$fieldname1=if(2 -gt $correctcolumns) {$null} else {$fieldnames[0].psobject.Properties.name.GetValue(1)}
$fieldname2=if(3 -gt $correctcolumns) {$null} else {$fieldnames[0].psobject.Properties.name.GetValue(2)}
$fieldname3=if(4 -gt $correctcolumns) {$null} else {$fieldnames[0].psobject.Properties.name.GetValue(3)}
$fieldname4=if(5 -gt $correctcolumns) {$null} else {$fieldnames[0].psobject.Properties.name.GetValue(4)}
$fieldname5=if(6 -gt $correctcolumns) {$null} else {$fieldnames[0].psobject.Properties.name.GetValue(5)}
$fieldname6=if(7 -gt $correctcolumns) {$null} else {$fieldnames[0].psobject.Properties.name.GetValue(6)}
$fieldname7=if(8 -gt $correctcolumns) {$null} else {$fieldnames[0].psobject.Properties.name.GetValue(7)}
$columns=((Get-Content $path)[0] -split ",").count
$correctcolumnstest=2 ### This variable is hard coded currently but should be parsed in the future
$importcsv=Import-Csv $path
$nullfields=$importcsv | ForEach {$_ -replace '=;', 'empty'} | ForEach {$_ -replace '=}', 'empty'}
$n=1
###Check correct number of columns
Get-Content $path | Select-Object -First 1 "-End-"
    if($columns -ne $correctcolumnstest){
       Write-host "Incorrect number of columns"
    }
###Check for illegal characters
Get-Content $path | ForEach-Object {
    if($_ -match '"'){
    Write-host "Line" $_.ReadCount "contains comma:" $_
    }
    if($_ -match " "){
       Write-host "Line" $_.ReadCount "contains whitespace:" $_
    }
 } 
###Check for NULL fields
$nullfields | ForEach-Object {
    $n=$n+1
    if($_ -match 'empty'){
        Write-host "Line" $n "contains a NULL field"
    }
}
###Check for duplicates in each column (up to 8 columns)
$importcsv | 
Group-Object -Property $fieldname0 | 
    Where-Object { $_.count -ge 2 } | 
        Foreach-Object { $_.Group } {Write-Host "Duplicate entry:" $_.name "in" $fieldname0 "column"} 
    if($null -ne $fieldname1) {$importcsv | 
        Group-Object -Property $fieldname1 | 
            Where-Object { $_.count -ge 2 } | 
                Foreach-Object { $_.Group } {Write-Host "Duplicate entry:" $_.name "in" $fieldname1 "column"}
                }
    if($null -ne $fieldname2){$importcsv | 
        Group-Object -Property $fieldname2 | 
            Where-Object { $_.count -ge 2 } | 
                Foreach-Object { $_.Group } {Write-Host "Duplicate entry:" $_.name "in" $fieldname2 "column"}
                }
    if($null -ne $fieldname3) {$importcsv | 
        Group-Object -Property $fieldname3 | 
            Where-Object { $_.count -ge 2 } | 
                Foreach-Object { $_.Group } {Write-Host "Duplicate entry:" $_.name "in" $fieldname3 "column"}
                }
    if($null -ne $fieldname4) {$importcsv | 
        Group-Object -Property $fieldname4 | 
            Where-Object { $_.count -ge 2 } | 
                Foreach-Object { $_.Group } {Write-Host "Duplicate entry:" $_.name "in" $fieldname4 "column"}
                }
    if($null -ne $fieldname5) {$importcsv | 
        Group-Object -Property $fieldname5 | 
            Where-Object { $_.count -ge 2 } | 
                Foreach-Object { $_.Group } {Write-Host "Duplicate entry:" $_.name "in" $fieldname5 "column"}
                }
    if($null -ne $fieldname6) {$importcsv | 
        Group-Object -Property $fieldname6 | 
            Where-Object { $_.count -ge 2 } | 
                Foreach-Object { $_.Group } {Write-Host "Duplicate entry:" $_.name "in" $fieldname6 "column"}
                }
    if($null -ne $fieldname7) {$importcsv | 
        Group-Object -Property $fieldname7 | 
            Where-Object { $_.count -ge 2 } | 
                Foreach-Object { $_.Group } {Write-Host "Duplicate entry:" $_.name "in" $fieldname7 "column"}
                }