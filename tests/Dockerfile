ARG IMAGE_NAME
FROM ${IMAGE_NAME}

ADD . /tests/
ENTRYPOINT ["run-parts"]
CMD ["-v", "--lsbsysinit", "/tests"]