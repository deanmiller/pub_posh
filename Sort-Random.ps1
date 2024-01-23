
Function Sort-Random
{
  Process{
    [array]$x = $x + $_
  }
  
  End{
    $x | Sort-Object {Get-Random}
  }
}
