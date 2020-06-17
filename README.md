# usd-build
Build the Pixar Universal Scene Description system.

## Prepare the image

    docker build --rm -t usd-build .

## Run the interactive shell for USD

Create a new build directory and execute the commands from there.

> Make sure to install the Pixar RenderMan before building the USD system so that the `$RMANTREE` environment variable points to RenderManProServer directory.

For Powershell console use this command:

    docker run --rm -it -v "$(pwd):c:/build" -v "$(echo $env:RMANTREE):c:/prman" usd-build

For GitBash console use this command:

    docker run --rm -it -v "$(pwd -W):c:/build" -v "$RMANTREE:c:/prman" usd-build

You may want to run the USD build command manually inside the interactive Powershell:

    python c:/usd/build_scripts/build_usd.py --openvdb --openimageio --opencolorio --alembic --hdf5 --prman --prman-location "c:/prman" c:/build/usd

## Build the USD system

Create a new build directory and execute the commands from there.

> Make sure to install the Pixar RenderMan before building the USD system so that the `$RMANTREE` environment variable points to RenderManProServer directory.

For Powershell console use this command to build the USD system in your build directory:

    docker run --rm -it -v "$(pwd):c:/build" -v "$(echo $env:RMANTREE):c:/prman" usd-build python c:/usd/build_scripts/build_usd.py --openvdb --openimageio --opencolorio --alembic --hdf5 --prman --prman-location "c:/prman" c:/build/usd

For GitBash console use this command to build the USD system in your build directory:

    docker run --rm -it -v "$(pwd -W):c:/build" -v "$RMANTREE:c:/prman" usd-build python c:/USD/build_scripts/build_usd.py --openvdb --openimageio --opencolorio --alembic --hdf5 --prman --prman-location "c:/prman" c:/build/usd

## Run the interactive shell for Maya USD plugin

Execute the commands from your build directory (USD system should be already built there).

> Make sure to download Maya devkit to your build directory and name it "devkit".

For Powershell console use this command:

    docker run --rm -it -v "$(pwd):C:/build" -v "c:/Program Files/Autodesk/Maya2020:c:/maya" usd-maya-build

For GitBash console use this command:

    docker run --rm -it -v "$(pwd -W):c:/build" -v "c:/Program Files/Autodesk/Maya2020:c:/maya" usd-maya-build

You may want to run the Maya USD plugin build command manually inside the interactive Powershell:

    python build.py --generator Ninja -v 3 --maya-location c:/maya --pxrusd-location c:/build/usd --devkit-location c:/build/devkit --install-location c:/build/usdplugin --build-args="-DBUILD_ADSK_PLUGIN=ON" --generator="Visual Studio 16 2019" c:/build/workspace

## Build Maya USD plugin

Execute the commands from your build directory (USD system should be already built there).

> Make sure to download Maya devkit to your build directory and name it "devkit".

For Powershell console use this command to build Maya USD plugin in your build directory:

    docker run --rm -it -v "$(pwd):c:/build" -v "$(echo $env:RMANTREE):c:/prman" usd-build python build.py --generator Ninja -v 3 --maya-location c:/maya --pxrusd-location c:/build/usd --devkit-location c:/build/devkit --install-location c:/build/usdplugin --build-args="-DBUILD_ADSK_PLUGIN=ON" --generator="Visual Studio 16 2019" c:/build/workspace

For GitBash console use this command to build Maya USD plugin in your build directory:

    docker run --rm -it -v "$(pwd -W):c:/build" -v "$RMANTREE:c:/prman" usd-build python build.py --generator Ninja -v 3 --maya-location c:/maya --pxrusd-location c:/build/usd --devkit-location c:/build/devkit --install-location c:/build/usdplugin --build-args="-DBUILD_ADSK_PLUGIN=ON" --generator="Visual Studio 16 2019" c:/build/workspace
