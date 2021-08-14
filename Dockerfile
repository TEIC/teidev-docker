FROM debian:bullseye-slim
#RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
# Hack to prevent openjdk-11 install failing
RUN mkdir /usr/share/man/man1/ 
# Enable contrib repo
RUN sed -i "s#deb http://deb.debian.org/debian bullseye main#deb http://deb.debian.org/debian bullseye main contrib#g" /etc/apt/sources.list
RUN apt-get update && apt-get -y install openjdk-11-jdk-headless \
  fonts-dejavu \
  fonts-junicode \
  fonts-linuxlibertine \
  fonts-noto \
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
  tidy \
  devscripts \
  xsltproc \
  debhelper \
  trang \
  jing \
  texlive-xetex \
  texlive-latex-extra \
  texlive-fonts-recommended \
  libexpat-dev \
  xzdec
RUN git clone https://github.com/dtolpin/RNV.git rnv && \
    cd rnv && \
    make -f Makefile.gnu rnv && \
    cp rnv /usr/bin/ && \
    cd ../ \
    rm -rf rnv
# Packaged Saxon is still v9.9.1.5
RUN wget -O SaxonHE10.zip https://downloads.sourceforge.net/project/saxon/Saxon-HE/10/Java/SaxonHE10-5J.zip
RUN unzip -d SaxonHE10 SaxonHE10.zip
RUN mv SaxonHE10/saxon-he-10.5.jar /usr/share/java/
RUN ln -s /usr/share/java/saxon-he-10.5.jar /usr/share/java/saxon-he-10.jar
RUN echo "#! /bin/bash" > /usr/local/bin/saxon \
    && echo "java -jar /usr/share/java/saxon-he-10.jar \$*" >> /usr/local/bin/saxon \
    && chmod 755 /usr/local/bin/saxon
WORKDIR /
ENTRYPOINT ["bash"]
