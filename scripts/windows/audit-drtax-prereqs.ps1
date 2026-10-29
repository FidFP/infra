[CmdletBinding()]
param(
    [Parameter()]
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'

function Get-RegistryApplications {
    $registryPaths = @(
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )

    Get-ItemProperty -Path $registryPaths -ErrorAction SilentlyContinue |
        Where-Object {
            $_.DisplayName -and
            $_.DisplayName -match '(?i)(Dr\.?\s*Tax|SQL Server|PostgreSQL|Java)'
        } |
        Select-Object DisplayName, DisplayVersion, Publisher, InstallLocation |
        Sort-Object DisplayName, DisplayVersion -Unique
}

function Get-RelevantServices {
    Get-CimInstance Win32_Service |
        Where-Object {
            $_.Name -match '(?i)(MSSQL|SQLBrowser|postgres|drtax)' -or
            $_.DisplayName -match '(?i)(SQL Server|PostgreSQL|Dr\.?\s*Tax)'
        } |
        Select-Object Name, DisplayName, State, StartMode, PathName
}

function Get-RelevantFirewallRules {
    if (-not (Get-Command Get-NetFirewallRule -ErrorAction SilentlyContinue)) {
        return @()
    }

    Get-NetFirewallRule -ErrorAction SilentlyContinue |
        Where-Object {
            $_.DisplayName -match '(?i)(Dr\.?\s*Tax|SQL|PostgreSQL)'
        } |
        Select-Object DisplayName, Enabled, Direction, Action, Profile
}

$computerSystem = Get-CimInstance Win32_ComputerSystem
$operatingSystem = Get-CimInstance Win32_OperatingSystem
$processor = Get-CimInstance Win32_Processor | Select-Object -First 1

$network = Get-NetIPConfiguration |
    Where-Object { $_.NetAdapter.Status -eq 'Up' } |
    ForEach-Object {
        [pscustomobject]@{
            InterfaceAlias = $_.InterfaceAlias
            InterfaceDescription = $_.InterfaceDescription
            MacAddress = $_.NetAdapter.MacAddress
            IPv4Address = @($_.IPv4Address.IPAddress)
            IPv4DefaultGateway = @($_.IPv4DefaultGateway.NextHop)
            DnsServers = @($_.DNSServer.ServerAddresses)
            DhcpEnabled = $_.NetIPv4Interface.Dhcp
        }
    }

$profiles = Get-NetConnectionProfile -ErrorAction SilentlyContinue |
    Select-Object Name, InterfaceAlias, NetworkCategory, IPv4Connectivity

$disks = Get-CimInstance Win32_LogicalDisk -Filter 'DriveType = 3' |
    Select-Object DeviceID,
        @{Name = 'SizeGB'; Expression = { [math]::Round($_.Size / 1GB, 2) }},
        @{Name = 'FreeGB'; Expression = { [math]::Round($_.FreeSpace / 1GB, 2) }}

$report = [ordered]@{
    SchemaVersion = 1
    CollectedAt = (Get-Date).ToString('o')
    ReadOnlyAudit = $true
    Computer = [ordered]@{
        Name = $env:COMPUTERNAME
        Manufacturer = $computerSystem.Manufacturer
        Model = $computerSystem.Model
        TotalPhysicalMemoryGB = [math]::Round($computerSystem.TotalPhysicalMemory / 1GB, 2)
        Processor = $processor.Name
    }
    OperatingSystem = [ordered]@{
        Caption = $operatingSystem.Caption
        Version = $operatingSystem.Version
        BuildNumber = $operatingSystem.BuildNumber
        Architecture = $operatingSystem.OSArchitecture
        LastBootTime = $operatingSystem.LastBootUpTime
    }
    Disks = @($disks)
    Network = @($network)
    NetworkProfiles = @($profiles)
    Applications = @(Get-RegistryApplications)
    Services = @(Get-RelevantServices)
    FirewallRules = @(Get-RelevantFirewallRules)
    RelevantPaths = [ordered]@{
        ProgramFilesDrTax = Test-Path 'C:\Program Files\DrTaxOfficeCH'
        ProgramFilesX86DrTax = Test-Path 'C:\Program Files (x86)\DrTaxOfficeCH'
        LegacyRootDrTax = Test-Path 'C:\DrTaxOfficeCH'
    }
}

$json = $report | ConvertTo-Json -Depth 8

if ($OutputPath) {
    $resolvedParent = Split-Path -Parent $OutputPath
    if ($resolvedParent -and -not (Test-Path -LiteralPath $resolvedParent)) {
        New-Item -ItemType Directory -Path $resolvedParent | Out-Null
    }
    Set-Content -LiteralPath $OutputPath -Value $json -Encoding utf8
    Write-Host "Audit écrit dans $OutputPath"
}
else {
    $json
}

