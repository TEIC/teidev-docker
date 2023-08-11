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
  tree \
  xzdec
RUN git clone https://github.com/hartwork/rnv.git rnv && \
    cd rnv && \
    make -f Makefile.gnu rnv && \
    cp rnv /usr/bin/ && \
    cd ../ \
    rm -rf rnv
# Stylesheets Saxon is older, so get latest
RUN wget -O SaxonHE11.zip https://downloads.sourceforge.net/project/saxon/Saxon-HE/11/Java/SaxonHE11-4J.zip; \
    unzip -d SaxonHE11 SaxonHE11.zip; \
    mv SaxonHE11/saxon-he-11.4.jar /usr/share/java/; \
    mkdir /usr/share/java/saxon-11; \
    cp SaxonHE11/lib/*.jar /usr/share/java/saxon-11; \
    ln -s /usr/share/java/saxon-he-11.4.jar /usr/share/java/saxon-he-11.jar; \
    echo "#! /bin/bash" > /usr/local/bin/saxon \
    && echo "java -cp /usr/share/java/saxon-11/*:/usr/share/java/saxon-he-11.jar net.sf.saxon.Transform \$*" >> /usr/local/bin/saxon \
    && chmod 755 /usr/local/bin/saxon

WORKDIR /
ENTRYPOINT ["bash"]
