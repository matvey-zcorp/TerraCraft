# Variables
venvActivate = .venv\Scripts\Activate.ps1
srcDir = .\src
gameFile = game.py
distDir = .\dist
tempDir = .\temp
icon = icon.ico
venv = .venv
requirementsFile = requirements.txt

# Settings
SHELL := powershell.exe
.SHELLFLAGS := -NoProfile -Command
.DEFAULT_GOAL := run
.PHONY: run build create install clean
.SILENT:

# Functions
run:
	Write-Output "Activating venv..."
	$(venvActivate)
	Write-Output "Running..."
	Set-Location $(srcDir) | python .\$(gameFile)
	Write-Output "Program exited!"

build:
	Write-Output "Activating venv..."
	$(venvActivate)
	Write-Output "Building..."
	cd $(distDir)
	pyinstaller --onefile --noconsole --icon=..\$(srcDir)\$(icon) ..\$(srcDir)\$(gameFile)
	Write-Output "Builed!"

create:
	Write-Output "Creating venv..."
	python -m venv $(venv)
	Write-Output "Created!"

install:
	Write-Output "Activating venv..."
	$(venvActivate)
	Write-Output "Installing requirements..."
	pip install -r $(requirementsFile)
	Write-Output "Installed!"

clean:
	Write-Output "Cleaning dist and temp..."
	Remove-Item -LiteralPath '$(distDir)' -Recurse --Force
	Remove-Item -LiteralPath '$(tempDir)' -Recurse --Force
	New-Item -ItemType Directory -Path $(distDir)
	New-Item -ItemType Directory -Path $(tempDir)
	Write-Output "Cleaned!"
