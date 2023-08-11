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
  asciidoc \
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
  libexpat-dev \
  tree \
  xzdec
RUN git clone https://github.com/hartwork/rnv.git rnv && \
    cd rnv && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install && \
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
