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
      python-pip python-setuptools \
      lmodern \
      wget && \
    mkdir -p /tmp/ && \
    wget https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb --no-check-certificate -O /tmp/pandoc.deb && \
    dpkg -i /tmp/pandoc.deb && rm -rf /tmp/pandoc.deb && \
    pip install -U pip setuptools && pip install panflute && pip install pandoc-img-glob \
    apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/
   
WORKDIR /source

ENTRYPOINT ["/usr/bin/pandoc"]

CMD ["--help"]
