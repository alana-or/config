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

# Criar pasta dos projetos
New-Item -Path C:\Projetos -ItemType Directory

# Definir o caminho da pasta dos projetos
$projectPath = "C:\Projetos"

# Definir o conteúdo a ser adicionado ao perfil do PowerShell
$powerShellProfileContent = @"
Set-Location -Path '$projectPath'
"@

# Definir o caminho do arquivo de perfil do PowerShell
$powerShellProfilePath = $PROFILE

# Adicionar conteúdo ao perfil do PowerShell
Add-Content -Path $powerShellProfilePath -Value $powerShellProfileContent

# Instalar Chocolatey se não estiver instalado
Install-Chocolatey

# Atualizar Chocolatey
choco upgrade chocolatey -y

# Instalar software
choco install git -y
choco install git.install -y
choco install git-credential-manager-core -y
choco install docker-desktop -y
choco install vscode -y
choco install dotnet-sdk -y
choco install visualstudio2019community -y
choco install microsoft-windows-terminal -y
choco install powershell-core -y
choco install dbeaver -y
choco install nodejs
choco install googlechrome
choco install firefox
choco install postman

#GIT
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.sw 'switch'
git config --global alias.fe 'fetch'
git config --global alias.ps 'push'
git config --global alias.pl 'pull'

# Ativar recurso WSL e configurar WSL 2
Write-Host "Ativando recursos necessários para WSL 2..."
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Instalar kernel WSL 2
Write-Host "Instalando o kernel WSL 2..."
wsl --install

# Instalar Ubuntu para WSL
#choco install ubuntu -y

# Definir WSL 2 como versão padrão
Write-Host "Configurando WSL 2 como a versão padrão..."
wsl --set-default-version 2

# Reiniciar o sistema para aplicar as mudanças
Write-Host "A instalação requer uma reinicialização para completar a configuração."
Write-Host "Deseja reiniciar o computador agora? (S/N)"
$restart = Read-Host
if ($restart -eq 'S' -or $restart -eq 's') {
    Restart-Computer
} else {
    Write-Host "Por favor, reinicie o computador manualmente para concluir a instalação."
}

Write-Host "Instalação de software completa. Verifique se há etapas adicionais para configurar Docker."
