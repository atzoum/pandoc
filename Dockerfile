FROM ubuntu:xenial

ENV PANDOC_VERSION "2.1.2"

# install latex packages
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
      texlive-latex-base \
      texlive-xetex latex-xcolor \
      texlive-math-extra \
      texlive-latex-extra \
      texlive-fonts-extra \
      texlive-bibtex-extra \
      fontconfig \
      python3 python3-pip python3-setuptools \
      lmodern \
      wget \
      locales \
      groovy2 && \
    locale-gen en_US.UTF-8 && \
    mkdir -p /tmp/ && \
    wget https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb --no-check-certificate -O /tmp/pandoc.deb && \
    wget https://github.com/dfrommi/groovy-pandoc/releases/download/v0.8/GroovyPandoc-0.8.jar -O /usr/share/groovy2/lib/groovy-pandoc.jar && \
    dpkg -i /tmp/pandoc.deb && rm -rf /tmp/pandoc.deb && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 100 && \
    update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 100 && \
    pip install -U pip setuptools && \
    pip install panflute && \
    pip install pandoc-img-glob && \
    apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/
ENV LANG=en_US.UTF-8
WORKDIR /source

ENTRYPOINT ["/usr/bin/pandoc"]

CMD ["--help"]
