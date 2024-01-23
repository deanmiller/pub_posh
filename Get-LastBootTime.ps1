
Function Get-LastBootTime
{

  <#
  .Synopsis

  .Description

  .Example
   Get-LastBootTime -ComputerName $ComputerName  

  .Link
   about_functions
   about_functions_advanced
   about_functions_advanced_methods
   about_functions_advanced_parameters

  .Notes
   NAME:      Get-LastBootTime
   AUTHOR:    Dean Miller
   LASTEDIT:  1/1/2020
   #Requires -Version 3.0
  #>

  [CmdletBinding()]
  param(
  [Parameter(Position=0, Mandatory=$true, ValueFromPipeline=$true)]
  [Alias('cn')]
  $ComputerName = "."
  )

  Process
  {

    if($ComputerName -eq '.'){$ComputerName = $env:COMPUTERNAME}	
    $ComputerName = $ComputerName.ToUpper()
    
    $Wmi = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $ComputerName
    $LastBootTime = $Wmi.ConvertToDateTime($wmi.Lastbootuptime)
    [TimeSpan]$Uptime = New-TimeSpan $LastBootTime $(Get-Date)
    [string]$SystemUptime = "$($Uptime.days) Days, $($Uptime.hours) Hours, $($Uptime.minutes) Minutes, $($Uptime.seconds) Seconds"
    
    if($ComputerName -eq $env:COMPUTERNAME){
      [pscustomobject][ordered]@{
        LastBootTime = $LastBootTime
        SystemUptime = $SystemUptime
      }
    }else{
      [pscustomobject][ordered]@{
        LastBootTime = $LastBootTime
        SystemUptime = $SystemUptime
        ComputerName = $ComputerName
      }
    }#if

  }# End Process

}# End Function Get-LastBootTime
