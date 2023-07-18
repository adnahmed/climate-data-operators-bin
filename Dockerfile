FROM ubuntu:22.04
# Install some core software
RUN apt-get update && apt-get install -y wget g++ make cmake gfortran \
    && rm -rf /var/lib/apt/lists/*

# Set up the components needed for format support for cdo
RUN apt-get update && apt-get install -y \
    nco netcdf-bin libhdf5-dev zlib1g-dev libnetcdf-dev \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://confluence.ecmwf.int/download/attachments/45757960/eccodes-2.10.0-Source.tar.gz && \
    tar xvfz eccodes-2.10.0-Source.tar.gz && \
    mkdir build && \
    cd build && \
    cmake ../eccodes-2.10.0-Source/ -DCMAKE_INSTALL_PREFIX=/root/cdo-dist -DCMAKE_Fortran_FLAGS='-fallow-argument-mismatch' && \
    make install


RUN wget https://code.mpimet.mpg.de/attachments/download/18264/cdo-1.9.5.tar.gz && \
    tar xvfz cdo-1.9.5.tar.gz && \
    cd cdo-1.9.5 && \
    ./configure --prefix=/root/cdo-dist --with-eccodes=/root/cdo-dist --with-netcdf=/usr  --enable-netcdf4 && \
    make install

CMD /root/cdo-dist/bin/cdo --version
