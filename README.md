# apiui/apiuilazbuild

Docker with Lazarus and packages installed to build Linux binaries for apiUi and apiUiServer.

## Steps to build apiUi and/or apiUiServer

### Install Docker
see [Installing Docker](https://docs.docker.com/desktop/windows/install/)

### pull docker apiuilazbuilder repository 
```
docker pull apiui/apiuilazbuild
```

## Clone apiUi repository
You can find apiUi and apiUiServer sources [here](https://github.com/apiui/apiui).

## Change working directory
Open a Powershell at the subfolder Lazarus of the apiUi clone.

## build apiUi
```
docker run -it --rm -v ${PWD}:/home/lazarus apiuilazbuild apiUi/apiUi.lpi
```

## build apiUiServer
```
docker run -it --rm -v ${PWD}:/home/lazarus apiuilazbuild apiUiServer/apiUiServer.lpi
```
