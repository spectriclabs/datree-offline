# datree-offline

This repository creates offline versions of [Datree](https://datree.io) that include [Kubernetes JSON schemas](https://github.com/yannh/kubernetes-json-schema) directly within the the Docker image.

## Versions

Because there are so many versions of the Kubernetes JSON schemas, they cannot all be included in a single Docker image.  Therefore, separate Docker images are created for each schema version.  For example, there's a `datree-offline:v1.24.6-standalone-strict` image that corresponds with the [v1.24.6-standalone-strict schema](https://github.com/yannh/kubernetes-json-schema/tree/master/v1.24.6-standalone-strict).  Choose the image that matches the Kubernetes version you have deployed.

## Usage

Here's how to use it on the command line, which can be adapted to your CI/CD environment.  Datree is already configured to run offline within the container.  The only things that really need to be modified here are the schema version, the `policies.yaml` config path, and the file(s) to check at the end.

```sh
docker run --network=none -it --rm -v `pwd`:/tmp ghcr.io/spectriclabs/datree-offline:v1.24.6-standalone-strict \
  test --no-record --schema-location='/schema/{{.ResourceKind}}{{.KindSuffix}}.json' \
  --schema-version=1.24.6 \
  --policy-config=/container/path/to/policies.yaml /container/path/to/check/*.yaml
```

## Policies

The default policies are available within the container at `/policies/default.yaml`, copied from [here](https://github.com/datreeio/datree/blob/main/examples/defaultPaC/policies.yaml).

## License

As of this writing, both Datree and the Kubernetes JSON schemas use Apache 2.0 licenses.  The Apache 2.0 license file in this repo only covers this repo.
