FROM docker.io/library/debian:trixie-20261104

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential dos2unix ca-certificates wget bsdextrautils

RUN wget -q https://github.com/rhboot/shim/releases/download/16.1/shim-16.1.tar.bz2
RUN echo "46319cd228d8f2c06c744241c0f342412329a7c630436fce7f82cf6936b1d603  shim-16.1.tar.bz2" | sha256sum -c
RUN tar -xjf shim-16.1.tar.bz2

WORKDIR /shim-16.1
COPY . /shim-review
RUN cp /shim-review/sbat.pond.csv data/

RUN make VENDOR_CERT_FILE=/shim-review/pond.cer

RUN hexdump -Cv /shim-review/shimx64.efi > orig && \
    hexdump -Cv shimx64.efi > build && \
    diff -u orig build && \
    sha256sum /shim-review/shimx64.efi shimx64.efi
