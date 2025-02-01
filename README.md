# PPM

Use `npm`-like commands to manage `pip` and `venv` in PowerShell.

## Install

1. Clone
   ```powershell
   git clone https://github.com/0miles/ppm.git "$HOME\ppm"
   ```
   This will clone the `ppm` script into your home directory.

2. Add the following content to the Profile
   ```powershell
   # Load ppm.ps1 from the cloned repository
   if (Test-Path "$HOME\ppm\ppm.ps1") {
       . "$HOME\ppm\ppm.ps1"  # Ensure this matches the cloned path
   } else {
       Write-Host "Warning: ppm.ps1 not found in $HOME\ppm"
   }
   ```

3. Save and reload the `PROFILE`
   ```powershell
   . $PROFILE
   ```

## Usage

### Initialize a Virtual Environment

```powershell
ppm init
```

Creates a `.venv` virtual environment in the current directory.

```powershell
ppm init project_name
```

Creates a `project_name` directory and initializes a `.venv` virtual environment inside it.

### Activate the Virtual Environment

```powershell
ppm activate
```

Activates the `.venv` virtual environment.

### Deactivate the Virtual Environment

```powershell
ppm deactivate
```

Deactivates the currently active `.venv` virtual environment.

### Install Packages

```powershell
ppm i
```

Installs all dependencies from `requirements.txt`.

```powershell
ppm i package_name
```

Installs a specific package and updates `requirements.txt`.

```powershell
ppm i package1 package2 ...
```

Installs multiple packages and updates `requirements.txt`.

### Uninstall Packages

```powershell
ppm remove package_name
```

Removes a specific package and updates `requirements.txt`.

### List Installed Packages

```powershell
ppm list
```

Displays all installed packages in the virtual environment.

### Update Packages

```powershell
ppm update package_name
```

Upgrades a specific package and updates `requirements.txt`.

### Run a Python Script

```powershell
ppm run script.py
```

Executes a Python script within the virtual environment.

