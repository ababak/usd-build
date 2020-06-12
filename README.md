# usd-build
Build the Pixar Universal Scene Description system

## Prepare the image

    docker build --rm -t usd-build .

## Run the interactive shell

> Make sure to install the Pixar RenderMan before building the USD system so that the `$RMANTREE` environment variable points to RenderManProServer directory.

For Powershell console use this command:

    docker run --rm -it -v "$(pwd):c:/build" -v "$(echo $env:RMANTREE):c:/prman" usd-build

For GitBash console use this command:

    docker run --rm -it -v "$(pwd -W):c:/build" -v "$RMANTREE:c:/prman" usd-build

You may want to run the USD build command manually inside the interactive Powershell:

    python c:/usd/build_scripts/build_usd.py --openvdb --openimageio --opencolorio --alembic --hdf5 --prman --prman-location "c:/prman" c:/build/usd

## Build the USD system

> Make sure to install the Pixar RenderMan before building the USD system so that the `$RMANTREE` environment variable points to RenderManProServer directory.

For Powershell console use this command to build the USD system in the current directory:

    docker run --rm -it -v "$(pwd):c:/build" -v "$(echo $env:RMANTREE):c:/prman" usd-build python c:/USD/build_scripts/build_usd.py --openvdb --openimageio --opencolorio --alembic --hdf5 --prman --prman-location "c:/prman" c:/build/usd

For GitBash console use this command to build the USD system in the current directory:

    docker run --rm -it -v "$(pwd -W):c:/build" -v "$RMANTREE:c:/prman" usd-build python c:/USD/build_scripts/build_usd.py --openvdb --openimageio --opencolorio --alembic --hdf5 --prman --prman-location "c:/prman" c:/build/usd
