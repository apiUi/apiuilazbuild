FROM debian:latest
MAINTAINER Jan Bouwman <jan.bouwman@ziggo.nl>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget binutils gcc libgtk2.0-0 libgtk2.0-dev psmisc zip unzip 

# Install Lazarus 2.0.12 & the free pascal compiler 3.2.0
RUN echo "Downloading and installing Debians" && \
    wget "https://sourceforge.net/projects/lazarus/files/Lazarus%20Linux%20amd64%20DEB/Lazarus%202.0.12/fpc-laz_3.2.0-1_amd64.deb" -O fpc.deb && \
    wget "https://sourceforge.net/projects/lazarus/files/Lazarus%20Linux%20amd64%20DEB/Lazarus%202.0.12/fpc-src_3.2.0-1_amd64.deb" -O fpc-src.deb &&\
    wget "https://sourceforge.net/projects/lazarus/files/Lazarus%20Linux%20amd64%20DEB/Lazarus%202.0.12/lazarus-project_2.0.12-0_amd64.deb"  -O lazarus.deb

RUN dpkg -i --force-depends fpc-src.deb && rm fpc-src.deb && \
    dpkg -i --force-depends fpc.deb && rm fpc.deb && \
    dpkg -i --force-depends lazarus.deb && rm lazarus.deb

# install apiUi/apiUiServer dependencies:
RUN mkdir /install && cd /install && \
    wget "https://packages.lazarus-ide.org/Indy10.zip" && unzip Indy10.zip && lazbuild Indy10/indylaz.lpk && rm Indy10.zip &&\
    wget "https://packages.lazarus-ide.org/Abbrevia.zip" && unzip Abbrevia.zip && lazbuild Abbrevia/packages/Lazarus/abbrevia.lpk && rm Abbrevia.zip && \
    wget "https://packages.lazarus-ide.org/LCLExtensions.zip" && unzip LCLExtensions.zip && lazbuild lclextensions/lclextensions_package.lpk && rm LCLExtensions.zip && \
    wget "https://packages.lazarus-ide.org/VirtualTreeViewV5.zip" && unzip VirtualTreeViewV5.zip && lazbuild VirtualTreeView\ V5/Source/virtualtreeview_package.lpk && rm VirtualTreeViewV5.zip && \
    wget "https://packages.lazarus-ide.org/HtmlViewer.zip" && unzip HtmlViewer.zip && lazbuild HtmlViewer/package/FrameViewer09.lpk  && rm HtmlViewer.zip && \
    wget "https://github.com/mriscoc/fpc-markdown/archive/refs/tags/v1.1.1.zip" && unzip v1.1.1.zip && lazbuild fpc-markdown-1.1.1/fpc_markdown.lpk && rm v1.1.1.zip

RUN apt-get clean && apt-get autoremove -y

WORKDIR /home/lazarus
VOLUME /home/lazarus
ENTRYPOINT ["lazbuild"]
