FROM debian:latest

# Set timezone to a specific value and prevent interactive prompots
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Paris

# Install GNU parallel
RUN apt update \
    && apt install -y parallel
# Install Python and required modules (try to install modules later)
RUN apt-get update && apt-get install -y python3
RUN apt-get update && apt-get install -y python3-biopython
RUN apt-get update && apt-get install -y python3-six
RUN apt-get update && apt-get install -y python3-ete3
#RUN apt-get update && apt-get install -y python3-bitvector
RUN apt-get update && apt-get install -y python3-weblogo

#RUN pip3 install biopython ete3 bitvector weblogo
#oder RUN pip3 install BioPython numpy ete3 BitVector weblogo


# Install R and the ape package
RUN apt-get update && apt-get install -y r-base
# Install required R packages
RUN Rscript -e "install.packages('ape')"

# Install HMMER 3, mmseq and cmake
RUN apt-get update && apt-get install -y hmmer build-essential cmake mmseqs2

# Install _mpi suffixed binaries (this is new)
RUN apt-get update && apt-get install -y mpi-default-bin mpi-default-dev

# Install git and autoconf
RUN apt-get update && apt-get install -y git autoconf

# Copy data to the container
COPY bash_scripts /bash_scripts
COPY pfamtab /pfamta