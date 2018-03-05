FROM haskell:8.0

ENV PANDOC_VERSION "1.19.2.1"

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
      python-pip \
      lmodern && \
    cabal update && cabal install pandoc-${PANDOC_VERSION} && \
    pip install pandoc-img-glob && \
    apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/
   

# install pandoc
RUN cabal update && cabal install pandoc-${PANDOC_VERSION}

WORKDIR /source

ENTRYPOINT ["/root/.cabal/bin/pandoc"]

CMD ["--help"]
