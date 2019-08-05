ARG IMAGE_NAME
FROM ${IMAGE_NAME}

ADD *.sh /tests/
ENTRYPOINT ["run-parts"]
CMD ["-v", "--regex", ".*sh$", "--exit-on-error", "/tests"]