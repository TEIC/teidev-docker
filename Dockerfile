FROM debian:buster
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get -y install openjdk-11-jdk \
  ttf-dejavu \
  fonts-junicode \
  fonts-linuxlibertine \
  fonts-noto-cjk \
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
RUN apt-get update && apt-get -y install ant \
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
WORKDIR /
ENTRYPOINT ["bash"]
