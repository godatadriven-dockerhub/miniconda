FROM debian:stretch

ARG BUILD_DATE
ARG MINICONDA_VERSION=3

LABEL org.label-schema.name="Continuum Miniconda $MINICONDA_VERSION" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$MINICONDA_VERSION

ENV PATH="/opt/miniconda${MINICONDA_VERSION}/bin:${PATH}"

RUN apt-get update && \
    apt-get install -y curl bzip2 && \
    curl -s --url "https://repo.continuum.io/miniconda/Miniconda${MINICONDA_VERSION}-latest-Linux-x86_64.sh" --output /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -f -p "/opt/miniconda${MINICONDA_VERSION}" && \
    rm /tmp/miniconda.sh && \
    apt-get remove -y curl bzip2 && \
    apt-get clean && \
    conda config --set auto_update_conda true && \
    conda config --set channel_priority false && \
    conda update conda -y --force && \
    conda clean -tipsy    
    
ENTRYPOINT ["conda"]
CMD ["--help"]