# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Definir uma função para verificar se o Chocolatey está instalado
function Install-Chocolatey {
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Instalando Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }
    else {
        Write-Host "Chocolatey já está instalado."
    }
}

# Instalar Chocolatey se não estiver instalado
Install-Chocolatey

# Atualizar Chocolatey
choco upgrade chocolatey

# Instalar software
choco install git -y
choco install git.install -y
choco install git-credential-manager-core -y
choco install docker-desktop -y
choco install vscode -y
choco install visualstudio2019community -y
choco install microsoft-windows-terminal -y
choco install powershell-core -y
choco install dbeaver -y
choco install wsl2 -y
choco install ubuntu -y

# Verificar instalações adicionais específicas
Write-Host "Instalação de software completa. Verifique se há etapas adicionais para configurar WSL2 e Docker."
