FROM debian:stretch-slim

ARG BUILD_DATE
ARG MINICONDA_VERSION=3
ARG PYTHON_VERSION

LABEL org.label-schema.name="Continuum Miniconda $PYTHON_VERSION" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.version=$MINICONDA_VERSION

ENV PATH="/opt/miniconda${MINICONDA_VERSION}/bin:${PATH}"

RUN set -x && \
    apt-get update && \
    apt-get install -y curl bzip2 && \
    curl -s --url "https://repo.continuum.io/miniconda/Miniconda${MINICONDA_VERSION}-latest-Linux-x86_64.sh" --output /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -f -p "/opt/miniconda${MINICONDA_VERSION}" && \
    rm /tmp/miniconda.sh && \
    apt-get purge -y --auto-remove curl bzip2 && \
    apt-get clean && \
    conda config --set auto_update_conda true && \
    if [ -n "$PYTHON_VERSION" ]; then\
        conda install python=$PYTHON_VERSION -y --force;\
    fi && \
    if [ "$MINICONDA_VERSION" = "2" ]; then\
        conda install -y futures;\
    fi && \
    conda update conda -y --force && \
    conda clean -tipsy && \
    find /opt/miniconda${MINICONDA_VERSION} -depth \( \( -type d -a \( -name test -o -name tests \) \) -o \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \) | xargs rm -rf && \
    echo "PATH=/opt/miniconda${MINICONDA_VERSION}/bin:\${PATH}" > /etc/profile.d/miniconda.sh

ENTRYPOINT ["conda"]
CMD ["--help"]
