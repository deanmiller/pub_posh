
Function ConvertTo-ASCII
{

  <#
  .Synopsis

  .Description

  .Example
   ConvertTo-ASCII -Text 'TGIF!'

  .Example
   $GithubToken = 'xxxxxxxxxxxxxxxxxxxxxxx'
   ConvertTo-ASCII -Text $GithubToken -OutCharacterMap

  .Link
   https://social.technet.microsoft.com/Forums/en-US/71da97e1-db2a-4049-bf7a-3691c0eda395/convert-character-to-ascii?forum=winserverpowershell

  .Notes
   NAME:      ConvertTo-ASCII
   AUTHOR:    Dean Miller
   LASTEDIT:  1/1/2020
   #Requires -Version 4.0
  #>

  [CmdletBinding()]
  param(
  [Parameter(Position=0,Mandatory=$true)]
  $Text,
  [Parameter(Position=1)]
  [switch]$OutCharacterMap = $false
  )

  Process
  {

    $Chars = [int[]][char[]]$Text
    $CharMap = '([char[]]('
    [string]$C = foreach($Char in $Chars){"$Char,"}
    $CharMap += $C.Substring(0,($C.Length - 1)).Replace(' ','')
    $CharMap += ") -Join '')"

    if($OutCharacterMap){
      $CharMap
    }else{
      [pscustomobject][ordered]@{
        Text         = $Text
        ASCIICodes   = $Chars
        CharacterMap = [string]$CharMap
      }
    }

  }# End Process

}# End Function ConvertTo-ASCII
