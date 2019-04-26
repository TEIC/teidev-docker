FROM ubuntu:18.04
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get -y install openjdk-8-jdk \
  ttf-dejavu \
  fonts-arphic-ukai \
  fonts-arphic-uming \
  fonts-baekmuk \
  fonts-junicode \
  fonts-linuxlibertine \
  rename \
  wget \
  curl \
  zip
RUN mkdir /usr/share/fonts/truetype/hannom
WORKDIR /usr/share/fonts/truetype/hannom
RUN wget -O hannom.zip http://downloads.sourceforge.net/project/vietunicode/hannom/hannom%20v2005/hannomH.zip
RUN unzip hannom.zip
RUN find . -iname "*.ttf" | rename 's/\ /_/g'
RUN rm hannom.zip
RUN fc-cache -f -v
RUN apt-get update && apt-get -y install fonts-ipafont-gothic \
  fonts-ipafont-mincho \
  ant \
  git \
  libxml2 \
  libxml2-utils \
  devscripts \
  xsltproc \
  libsaxonhe-java \
  debhelper \
  trang \
  jing \
  texlive-xetex \
  texlive-latex-extra \
  texlive-generic-recommended \
  texlive-fonts-recommended \
  libexpat-dev
RUN git clone https://github.com/dtolpin/RNV.git rnv && \
    cd rnv && \
    make -f Makefile.gnu rnv && \
    cp rnv /usr/bin/ && \
    cd ../
RUN echo "#! /bin/bash" > /usr/local/bin/saxon \
    && echo "java -jar /usr/share/java/Saxon-HE.jar \$*" >> /usr/local/bin/saxon \
    && chmod 755 /usr/local/bin/saxon
WORKDIR /
ENTRYPOINT ["bash"]
