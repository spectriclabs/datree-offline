# datree-offline

This repository creates offline versions of [Datree](https://datree.io) that include [Kubernetes JSON schemas](https://github.com/yannh/kubernetes-json-schema) directly within the the Docker image.

## Versions

Because there are so many versions of the Kubernetes JSON schemas, they cannot all be included in a single Docker image.  Therefore, separate Docker images are created for each schema version.  For example, there's a `datree-offline:v1.24.6-standalone-strict` image that corresponds with the [v1.24.6-standalone-strict schema](https://github.com/yannh/kubernetes-json-schema/tree/master/v1.24.6-standalone-strict).  Choose the image that matches the Kubernetes version you have deployed.

## Usage

The `ENTRYPOINT` for each Docker image already includes the necessary parameters to use Datree in an offline manner.  Here's how to use it on the command line, which can be adapted to your CI/CD environment.

```sh
docker run -it --rm -v `pwd`:/tmp ghcr.io/spectriclabs/datree-offline:v1.24.6-standalone-strict test /tmp/somefile.yaml
```

## License

As of this writing, both Datree and the Kubernetes JSON schemas use Apache 2.0 licenses.  The Apache 2.0 license file in this repo only covers this repo.
