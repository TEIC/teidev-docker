FROM debian:bullseye-slim
# Set LANG to UTF-8
ENV LANG=C.UTF-8
# Enable contrib repo
RUN sed -i "s#deb http://deb.debian.org/debian bullseye main#deb http://deb.debian.org/debian bullseye main contrib#g" /etc/apt/sources.list
RUN apt-get update && apt-get -y install openjdk-17-jdk-headless \
  ant \
  ant-contrib \
  curl \
  debhelper \
  devscripts \
  fonts-dejavu \
  fonts-junicode \
  fonts-linuxlibertine \
  fonts-noto \
  fonts-noto-cjk \
  fonts-noto-cjk-extra \
  git \
  jing \
  jq \
  libexpat-dev \
  libxml2 \
  libxml2-utils \
  rename \
  rsync \
  texlive-xetex \
  texlive-latex-extra \
  texlive-fonts-recommended \
  tidy \
  trang \
  tree \
  wget \
  xsltproc \
  xzdec
RUN apt-get --no-install-recommends -y install asciidoc
RUN apt-get install -y asciidoc-doc docbook-xml docbook-xsl
RUN git clone https://github.com/hartwork/rnv.git rnv && \
    cd rnv && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install && \
    rm -rf rnv
# Stylesheets Saxon is older, so get latest
RUN wget -O SaxonHE12.zip https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE12-5/SaxonHE12-5J.zip \
    unzip -d SaxonHE12 SaxonHE12.zip; \
    mv SaxonHE12/saxon-he-12.5.jar /usr/share/java/; \
    mkdir /usr/share/java/saxon-12; \
    cp SaxonHE12/lib/*.jar /usr/share/java/saxon-12; \
    ln -s /usr/share/java/saxon-he-12.5.jar /usr/share/java/saxon-he-12.jar; \
    echo "#! /bin/bash" > /usr/local/bin/saxon \
    && echo "java -cp /usr/share/java/saxon-12/*:/usr/share/java/saxon-he-12.jar net.sf.saxon.Transform \$*" >> /usr/local/bin/saxon \
    && chmod 755 /usr/local/bin/saxon

WORKDIR /
ENTRYPOINT ["bash"]
