FROM biodatageeks/cnv-opt-codex
MAINTAINER kusmirekwiktor@gmail.com

RUN Rscript -e "install.packages('ExomeDepth', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('ggplot2', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('clusterCrit', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "library(devtools);install_github('wkusmirek/CNV-opt-reference-sample-set-selector/REFERENCE.SAMPLE.SET.SELECTOR', build_vignettes = FALSE)"
