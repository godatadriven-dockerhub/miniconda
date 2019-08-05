FROM debian:stretch-slim

ARG BUILD_DATE
ARG MINICONDA_VERSION=3
ARG MINICONDA_RELEASE=latest
ARG PYTHON_VERSION

LABEL org.label-schema.name="Continuum Miniconda $PYTHON_VERSION" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$MINICONDA_VERSION-$MINICONDA_RELEASE

ENV PATH="/opt/miniconda${MINICONDA_VERSION}/bin:${PATH}"

RUN set -x && \
    apt-get update && \
    apt-get install -y curl bzip2 && \
    curl -s --url "https://repo.continuum.io/miniconda/Miniconda${MINICONDA_VERSION}-${MINICONDA_RELEASE}-Linux-x86_64.sh" --output /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -f -p "/opt/miniconda${MINICONDA_VERSION}" && \
    rm /tmp/miniconda.sh && \
    apt-get purge -y --auto-remove curl bzip2 && \
    apt-get clean && \
    conda config --set auto_update_conda true && \
    if [ "$MINICONDA_VERSION" = "2" ]; then\
        conda install -y futures;\
    fi && \
    if [ "$MINICONDA_RELEASE" = "latest" ]; then\
        conda update conda -y --force;\
    fi && \
    if [ "$PYTHON_VERSION" = "3.5" ]; then\
        conda install python=$PYTHON_VERSION conda=4.5.11 -y --force;\
    elif [ -n "$PYTHON_VERSION" ]; then\
        conda install python=$PYTHON_VERSION -y --force;\
    fi && \
    conda clean -tipsy && \
    echo "PATH=/opt/miniconda${MINICONDA_VERSION}/bin:\${PATH}" > /etc/profile.d/miniconda.sh

ENTRYPOINT ["conda"]
CMD ["--help"]
