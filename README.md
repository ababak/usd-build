# usd-build
Build the Pixar Universal Scene Description system and Maya USD plugin.

## Prepare the image

    docker build --rm -t usd-build .

## Build the USD system

Create a new build directory and execute the commands from there.

> Make sure to install the Pixar RenderMan before building the USD system so that the `$RMANTREE` environment variable points to RenderManProServer directory.

Execute this command to build the USD system in your build directory:

    docker run --rm -it -v "$(pwd):c:/build" -v "$(echo $env:RMANTREE):c:/prman" usd-build python c:/usd/build_scripts/build_usd.py --openvdb --openimageio --opencolorio --alembic --hdf5 --prman --prman-location "c:/prman" c:/build/usd

## Alternatively, run the interactive shell for USD

Create a new build directory and execute the commands from there.

> Make sure to install the Pixar RenderMan before building the USD system so that the `$RMANTREE` environment variable points to RenderManProServer directory.

Execute this command from the Powershell console:

    docker run --rm -it -v "$(pwd):c:/build" -v "$(echo $env:RMANTREE):c:/prman" usd-build

You may want to run the USD build command manually inside the interactive Powershell:

    python c:/usd/build_scripts/build_usd.py --openvdb --openimageio --opencolorio --alembic --hdf5 --prman --prman-location "c:/prman" c:/build/usd

## Build Maya USD plugin

Build the USD system first.

> Make sure to download Maya devkit into your build directory and name it "devkit".

Execute this command to build Maya USD plugin in your build directory:

    docker run --rm -it -v "$(pwd):c:/build" -v "c:/Program Files/Autodesk/Maya2020:c:/maya" usd-build python c:/maya-usd/build.py -v 3 --maya-location c:/maya --pxrusd-location c:/build/usd --devkit-location c:/build/devkit --install-location c:/build/usdplugin --build-args="-DBUILD_ADSK_PLUGIN=ON" --generator="Visual Studio 16 2019" c:/build/workspace

## Alternatively, run the interactive shell for Maya USD plugin

Build the USD system first.

> Make sure to download Maya devkit to your build directory and name it "devkit".

Execute this command from your build directory (USD system should be already built there).

    docker run --rm -it -v "$(pwd):C:/build" -v "c:/Program Files/Autodesk/Maya2020:c:/maya" usd-build

You may want to run the Maya USD plugin build command manually inside the interactive Powershell:

    python c:/maya-usd/build.py -v 3 --maya-location c:/maya --pxrusd-location c:/build/usd --devkit-location c:/build/devkit --install-location c:/build/usdplugin --build-args="-DBUILD_ADSK_PLUGIN=ON" --generator="Visual Studio 16 2019" c:/build/workspace
