function ppm {
    param (
        [string]$Command,
        [string[]]$Packages
    )

    function Update-Requirements {
        pip freeze | Out-File -Encoding utf8 requirements.txt
    }

    function Activate-Venv {
        if (-Not (Test-Path ".venv")) {
            Write-Host "Virtual environment not found. Please run 'ppm init' first."
            exit 1
        }
        if (-Not $env:VIRTUAL_ENV) {
            $venvPath = ".venv/Scripts/Activate.ps1"
            if (Test-Path $venvPath) {
                & $venvPath
                Write-Host "Activated virtual environment."
            } else {
                Write-Host "Failed to activate virtual environment."
                exit 1
            }
        }
    }

    function Deactivate-Venv {
        if ($env:VIRTUAL_ENV) {
            $deactivateScript = "$env:VIRTUAL_ENV\Scripts\deactivate.ps1"
            if (Test-Path $deactivateScript) {
                & $deactivateScript
                Write-Host "Deactivated virtual environment."
            } else {
                Write-Host "Deactivating by clearing environment variables."
                Remove-Item Env:\VIRTUAL_ENV -ErrorAction SilentlyContinue
            }
        } else {
            Write-Host "No virtual environment is currently active."
        }
    }

    switch ($Command) {
        "init" {
            if ($Packages.Count -eq 0) {
                if (-Not (Test-Path ".venv")) {
                    python -m venv .venv
                    Write-Host "Virtual environment created in .venv"
                } else {
                    Write-Host "Virtual environment already exists."
                }
            } else {
                $ProjectName = $Packages[0]
                if (-Not (Test-Path $ProjectName)) {
                    New-Item -ItemType Directory -Path $ProjectName | Out-Null
                }
                Set-Location $ProjectName
                if (-Not (Test-Path ".venv")) {
                    python -m venv .venv
                    Write-Host "Virtual environment created in $ProjectName/.venv"
                } else {
                    Write-Host "Virtual environment already exists in $ProjectName/.venv"
                }
                Set-Location ..
            }
        }
        "activate" {
            Activate-Venv
        }
        "a" {
            Activate-Venv
        }
        "deactivate" {
            Deactivate-Venv
        }
        "de" {
            Deactivate-Venv
        }
        "install" {
            Activate-Venv
            if (-Not (Test-Path "requirements.txt")) {
                Update-Requirements
            }
            if ($Packages.Count -eq 0) {
                pip install -r requirements.txt
            } else {
                pip install @Packages
                Update-Requirements
            }
        }
        "add" {
            ppm install @Packages
        }
        "i" {
            ppm install @Packages
        }
        "uninstall" {
            Activate-Venv
            if ($Packages.Count -eq 0) {
                Write-Host "Please specify a package to remove."
                return
            }
            pip uninstall -y @Packages
            Update-Requirements
        }
        "remove" {
            ppm uninstall @Packages
        }
        "list" {
            Activate-Venv
            pip list
        }
        "ls" {
            ppm list
        }
        "update" {
            Activate-Venv
            pip install --upgrade @Packages
            Update-Requirements
        }
        "upgrade" {
            ppm update @Packages
        }
        "run" {
            Activate-Venv
            & python @Packages
        }
        default {
            Write-Host "Usage: ppm init [project_name] | ppm activate | ppm deactivate | ppm install|add|i [package1 package2 ...] | ppm uninstall|remove package | ppm list|ls | ppm update|upgrade [package1 package2 ...] | ppm run script.py"
        }
    }
}
