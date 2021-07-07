# Minimal Docker image for vcf-split (latest) using Alpine base
FROM alpine:3.13.5
MAINTAINER Niema Moshiri <niemamoshiri@gmail.com>

# install vcf-split
RUN apk update && \
    apk add bash gcc make musl-dev && \
    wget "https://github.com/outpaddling/libxtend/archive/refs/heads/main.zip" && \
    unzip main.zip && \
    rm main.zip && \
    cd libxtend-main && \
    make PREFIX=/usr/local && \
    make install PREFIX=/usr/local && \
    cd .. && \
    wget "https://github.com/auerlab/biolibc/archive/refs/heads/master.zip" && \
    unzip master.zip && \
    rm master.zip && \
    cd biolibc-master && \
    sed -i 's/\.\.\/local\/include\/xtend\.h//g' Makefile.depend && \
    sed -i 's/\.\.\/local\/include\/xtend-protos\.h//g' Makefile.depend && \
    make PREFIX=/usr/local && \
    make install PREFIX=/usr/local && \
    cd .. && \
    wget "https://github.com/auerlab/vcf-split/archive/refs/heads/master.zip" && \
    unzip master.zip && \
    rm master.zip && \
    cd vcf-split-master && \
    make PREFIX=/usr/local && \
    make install PREFIX=/usr/local && \
    cd .. && \
    rm -rf biolibc-master libxtend-main vcf-split-master
