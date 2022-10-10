ARG schema_version

FROM alpine:3.16.2 AS clone_schema
ARG schema_version
RUN apk add git
RUN mkdir /schema /policies
RUN cd /schema && \
    git init && \
    git remote add origin https://github.com/yannh/kubernetes-json-schema.git && \
    git config core.sparseCheckout true && \
    echo v${schema_version}-standalone-strict >> .git/info/sparse-checkout && \
    git pull origin master
RUN cd /policies && \
    wget https://raw.githubusercontent.com/datreeio/datree/main/examples/defaultPaC/policies.yaml

FROM datree/datreeci:latest
ARG schema_version
COPY --from=clone_schema /schema/v${schema_version}-standalone-strict/ /schema
COPY --from=clone_schema /policies/policies.yaml /policies/default.yaml
RUN datree config set offline local

ENTRYPOINT ["datree"]
