ARG schema_version

FROM alpine:3.16.2 AS clone_schema
ARG schema_version
RUN apk add git
RUN mkdir /schema
RUN cd /schema && \
    git init && \
    git remote add origin https://github.com/yannh/kubernetes-json-schema.git && \
    git config core.sparseCheckout true && \
#    echo v1.24.6-standalone-strict >> .git/info/sparse-checkout && \
    echo $schema_version >> .git/info/sparse-checkout && \
    git pull origin master

FROM datree/datreeci:latest
ARG schema_version
COPY --from=clone_schema /schema/$schema_version/ /schema
RUN datree config set offline local
ENTRYPOINT ["datree", "--schema-location='/schema/{{.ResourceKind}}{{.KindSuffix}}.json'"]
