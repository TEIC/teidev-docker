FROM debian:buster
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get -y install openjdk-11-jdk \
  ttf-dejavu \
  fonts-junicode \
  fonts-linuxlibertine \
  fonts-noto-cjk \
  fonts-noto-cjk-extra \
  rename \
  wget \
  curl \
  ant \
  ant-contrib \
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
