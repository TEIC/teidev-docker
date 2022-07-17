FROM debian:bullseye-slim
# Enable contrib repo
RUN sed -i "s#deb http://deb.debian.org/debian bullseye main#deb http://deb.debian.org/debian bullseye main contrib#g" /etc/apt/sources.list
RUN apt-get update && apt-get -y install openjdk-17-jdk-headless \
  fonts-dejavu \
  fonts-junicode \
  fonts-linuxlibertine \
  fonts-noto \
  fonts-noto-cjk \
  fonts-noto-cjk-extra \
  rename \
  rsync \
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
# Stylesheets Saxon is older, so get latest
RUN wget -O SaxonHE11.zip https://downloads.sourceforge.net/project/saxon/Saxon-HE/11/Java/SaxonHE11-3J.zip; \
    unzip -d SaxonHE11 SaxonHE11.zip; \
    mv SaxonHE11/saxon-he-11.3.jar /usr/share/java/; \
    ln -s /usr/share/java/saxon-he-11.3.jar /usr/share/java/saxon-he-11.jar; \
    echo "#! /bin/bash" > /usr/local/bin/saxon \
    && echo "java -jar /usr/share/java/saxon-he-11.jar \$*" >> /usr/local/bin/saxon \
    && chmod 755 /usr/local/bin/saxon
WORKDIR /
ENTRYPOINT ["bash"]
