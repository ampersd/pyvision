########################################################### 
# AUTHOR  : Marius / Hican - http://www.hican.nl - @hicannl  
# DATE    : 05-07-2012  
# COMMENT : Scan for *.txt files recursively in the root
#           directory of the script. Compare the contents
#           of these files to an array of strings, which
#           are listed in the control file. Output the
#           successful results to the output file.
###########################################################

#ERROR REPORTING ALL
Set-StrictMode -Version latest

$path     = Split-Path -parent $MyInvocation.MyCommand.Definition
$files    = Get-Childitem $path *.py -Recurse | Where-Object { !($_.psiscontainer) }
$controls = Get-Content ($path + "\control_file.hican")
$output   = $path + "\output.log"

Function getStringMatch
{
  # Loop through all *.txt files in the $path directory
  Foreach ($file In $files)
  {
    # Loop through the search strings in the control file
    ForEach ($control In $controls)
    {
      $result = Get-Content $file.FullName | Select-String $control -quiet -casesensitive
      If ($result -eq $True)
      {
        $match = $file.FullName
        "Match on string :  $control  in file :  $match" | Out-File $output -Append
      }
    }
  }
}

getStringMatch