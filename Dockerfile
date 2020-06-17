# escape=`
#
# Author:
# Andriy Babak <ababak@gmail.com>
#
# Build the docker image:
# docker build --rm -t usd-build .
# See README.md for details


FROM mcr.microsoft.com/windows/servercore:ltsc2019 as base

LABEL maintainer="ababak@gmail.com"

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

ADD https://aka.ms/vscollect.exe C:\TEMP\collect.exe
ADD https://aka.ms/vs/16/release/channel C:\TEMP\VisualStudio.chman
ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe

# Install MSVC C++ compiler, CMake, and MSBuild.
RUN C:\TEMP\vs_buildtools.exe `
    --quiet --wait --norestart --nocache `
    --installPath C:\BuildTools `
    --channelUri C:\TEMP\VisualStudio.chman `
    --installChannelUri C:\TEMP\VisualStudio.chman `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended `
    --add Microsoft.Component.MSBuild `
    || IF "%ERRORLEVEL%"=="3010" EXIT 0

# Install Chocolatey package manager
RUN powershell.exe -ExecutionPolicy RemoteSigned `
    iex (New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'); `
    && SET "PATH=%PATH%;%ALLUSERSPROFILE%/chocolatey/bin"

# Install Chocolatey packages
RUN powershell.exe -ExecutionPolicy RemoteSigned `
    choco install python2 -y -o -ia "'/qn /norestart ALLUSERS=1 TARGETDIR=c:\Python27'"; `
    choco install 7zip -y; `
    choco install nasm -y; `
    choco install git -y; `
    choco install ninja -y

RUN setx `
    PATH "%PATH%;%PROGRAMFILES%/Git/bin;%PROGRAMFILES%/NASM;%PROGRAMFILES%/7-Zip;C:/Python27/Scripts"

# Install Python packages
RUN powershell.exe -ExecutionPolicy RemoteSigned `
    python -m pip install --upgrade pip`
    pyside `
    pyopengl `
    jinja2

ENV PYTHONIOENCODING UTF-8

# Download USD
RUN powershell.exe -ExecutionPolicy RemoteSigned `
    git clone --depth 1 https://github.com/PixarAnimationStudios/USD C:/usd

# Patch the include file to fix the compilation
# by adding a missing "#include <iostream>"
RUN powershell.exe -ExecutionPolicy RemoteSigned `
    "$fileName = 'C:/usd/pxr/imaging/hgi/attachmentDesc.h'; `
    Set-Content $fileName -Value ((Get-Content $fileName) -replace '#include <vector>', $(echo '$&'`n'#include <iostream>'))"

# Download Maya-USD
RUN powershell.exe -ExecutionPolicy RemoteSigned `
    git clone --depth 1 https://github.com/Autodesk/maya-usd C:/maya-usd

#######################################################

FROM base as prebuild

WORKDIR /build

ENTRYPOINT [ "C:\\BuildTools\\Common7\\Tools\\VsDevCmd.bat", "&&" ]

# python C:/usd/build_scripts/build_usd.py --openvdb --openimageio --opencolorio --alembic --hdf5 --prman --prman-location "C:/prman" C:/build/usd

CMD [ "powershell.exe", "-NoLogo", "-ExecutionPolicy", "Bypass" ]
