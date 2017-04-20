FROM ubuntu:14.04
RUN apt-get update
RUN apt-get -y install openjdk-7-jdk
RUN apt-get -y install ttf-dejavu fonts-arphic-ukai fonts-arphic-uming ttf-baekmuk ttf-junicode ttf-kochi-gothic ttf-kochi-mincho fonts-linuxlibertine
RUN apt-get -y install wget curl zip
RUN mkdir /usr/share/fonts/truetype/hannom
WORKDIR /usr/share/fonts/truetype/hannom
RUN wget -O hannom.zip http://downloads.sourceforge.net/project/vietunicode/hannom/hannom%20v2005/hannomH.zip
RUN unzip hannom.zip
RUN find . -iname "*.ttf" | rename 's/\ /_/g'
RUN rm hannom.zip
RUN fc-cache -f -v
RUN apt-get -y install fonts-ipafont-gothic fonts-ipafont-mincho
RUN apt-get -y install ant ant-contrib git libxml2 libxml2-utils devscripts xsltproc libsaxonhe-java debhelper trang jing
RUN apt-get -y install texlive-xetex texlive-latex-extra texlive-generic-recommended texlive-fonts-recommended
RUN apt-get -y install libexpat-dev
WORKDIR /tmp
RUN git clone https://github.com/dtolpin/RNV.git rnv && \
    cd rnv && \
    make -f Makefile.gnu rnv && \
    cp rnv /usr/bin/ && \
    cd ../
WORKDIR /
