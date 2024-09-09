# Check if R is installed
$r_path = Get-Command R -ErrorAction SilentlyContinue

if ($r_path) {
    Write-Output "R is already installed."
} else {
    Write-Output "R is not installed. Downloading and installing R..."
    $r_installer_url = "https://cloud.r-project.org/bin/windows/base/R-4.4.1-win.exe"
    $r_installer = "$env:TEMP\R_installer.exe"
    Invoke-WebRequest -Uri $r_installer_url -OutFile $r_installer
    Start-Process -FilePath $r_installer -ArgumentList "/VERYSILENT" -Wait
}

# Install necessary R libraries
R -e "if (!requireNamespace('BiocManager', quietly=TRUE)) install.packages('BiocManager')"               # Biostat Package manager
R -e "BiocManager::install('tidyverse')"       # For data manipulation and ggplot viz
R -e "BiocManager::install('DESeq2')"          # For differential expression
R -e "BiocManager::install('tximport')"        # Importing transcript abundance estimates

Write-Output "R setup complete with required packages!"
