FROM biodatageeks/cnv-opt-codex
MAINTAINER biodatageeks <team@biodatageeks.ii.pw.edu.pl>

ARG CACHE_DATE=not_a_specified_date

RUN Rscript -e "install.packages('ExomeDepth', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('ggplot2', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('clusterCrit', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('REFERENCE.SAMPLE.SET.SELECTOR', repos = NULL, type='source')"
