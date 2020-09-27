#region Think Ahead and Build Abstraction “Layers”

#requires -Module HyperV
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$VmName
)
## Use the Start-Vm cmdlet in the HyperV module to start a VM
Start-Vm -Name $VmName
## Do some stuff to the VM here
## Use the Stop-Vm cmdlet in the HyperV module to stop the VM
Stop-Vm -Name $VmName

#requires -Module HyperV, VmWare
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$VmName,
    [Parameter()]
    [ValidateSet('HyperV','VmWare')]
    [string]$Hypervisor
)
switch ($Hypervisor) {
    'HyperV' {
        ## Use the Start-Vm cmdlet in the HyperV module to start a VM
        Start-Vm -Name $VmName
        ## Do some stuff to the VM here
        ## Use the Stop-Vm cmdlet in the HyperV module to stop the VM
        Stop-Vm -Name $VmName
        break
    }
    'VmWare' {
        ## Use whatever command the VmWare module has in it to start the VM
        Start-VmWareVm -Name $VmName
        ## do stuff to the VmWare VM
        ## Use whatever command the VmWare module has in it to stop the VM
        Stop-VmWareVm -Name $VmName
        break
    }
    default {
        "The hypervisor you passed [$_] is not supported"
    }
}

#requires -Module HyperV, VmWare
[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$VmName
)
function Get-Hypervisor {
    ## simple helper function to determine the hypervisor
    param(
        [Parameter()]
        [string]$VmName
    )
    ## Some code here to figure out what type of hypervisor this VM is running on
    ## Return either 'HyperV' or 'VmWare'
}
$hypervisor = Get-Hypervisor -VmName $VmName
switch ($Hypervisor) {
    'HyperV' {
        ## Use the Start-Vm cmdlet in the HyperV module to start a VM
        Start-Vm -Name $VmName
        ## Do some stuff to the VM here
        ## Use the Stop-Vm cmdlet in the HyperV module to stop the VM
        Stop-Vm -Name $VmName
        break
    }
    'VmWare' {
        ## Use whatever command the VmWare module has in it to start the VM
        Start-VmWareVm -Name $VmName
        ## do stuff to the VmWare VM
        ## Use whatever command the VmWare module has in it to stop the VM
        Stop-VmWareVm -Name $VmName
        break
    }
    default {
        "The hypervisor you passed [$_] is not supported"
    }
}

#endregion

#region Make Module Functions Return Common Object Types

function Get-Thing {
    [CmdletBinding()]
    param()
    ## Do some stuff
    [pscustomobject]@{
        'Name' = 'XXXX'
        'Type' = 'XXXX'
    }
}
function Get-OtherThing {
    [CmdletBinding()]
    param()
        [pscustomobject]@{
            'Name' = 'XXXX'
            'Type' = 'XXXX'
            'Property1' = 'Value1'
            'Property2' = 'Value2'
        }
}


#endregion