FROM debian:bookworm-slim
# Set LANG to UTF-8
ENV LANG=C.UTF-8
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
RUN apt-get install -y docbook-xml docbook-xsl
RUN git clone https://github.com/hartwork/rnv.git rnv && \
    cd rnv && \
    ./bootstrap && \
    ./configure && \
    make && \
    make install && \
    rm -rf rnv
# Stylesheets Saxon is older, so get latest
RUN wget -O SaxonHE13.zip https://github.com/Saxonica/Saxon-HE/releases/download/SaxonHE13-0/SaxonHE13-0J.zip; \
    unzip -d SaxonHE13 SaxonHE13.zip; \
    mv SaxonHE13/saxon-he-13.0.jar /usr/share/java/; \
    mkdir /usr/share/java/saxon-13; \
    cp SaxonHE13/lib/*.jar /usr/share/java/saxon-13; \
    ln -s /usr/share/java/saxon-he-13.0.jar /usr/share/java/saxon-he-13.jar; \
    echo "#! /bin/bash" > /usr/local/bin/saxon \
    && echo "java -cp /usr/share/java/saxon-13/*:/usr/share/java/saxon-he-13.jar net.sf.saxon.Transform \$*" >> /usr/local/bin/saxon \
    && chmod 755 /usr/local/bin/saxon

WORKDIR /
ENTRYPOINT ["bash"]
