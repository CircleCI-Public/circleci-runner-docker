# CircleCI runner images

`circleci/runner` image is created by CircleCI to be with the [runner][] feature.

Currently the `launch-agent` tag can be used to run the launch-agent in a container colocated with the CircleCI job, i.e. the job will run inside the same container.

In the future a variant will be added that runs the `launch-agent` runs on the host and will run each job inside its own container (via the `task-agent`).

## Getting Started

This image can be used on a host with docker installed:

```bash
CIRCLECI_RESOURCE_CLASS=<resource-class> CIRCLECI_API_TOKEN=<runner-token> docker run --env CIRCLECI_API_TOKEN --env CIRCLECI_RESOURCE_CLASS --name <container-name> circleci/runner:launch-agent
```

## Contributing

We encourage [issues](https://github.com/CircleCI-Public/circleci-runner-docker/issues) and [pull requests](https://github.com/CircleCI-Public/circleci-runner-docker/pulls) against this repository.

For new feature requests, we encourage [Canny ideas](https://circleci.canny.io/runner-feature-requests).

## Additional Resources

- [Dockerhub Repository](https://hub.docker.com/r/circleci/runner) - DockerHub repository for the runner image
- [CircleCI Docs](https://circleci.com/docs/) - The official CircleCI Documentation website.
- [Runner Docs](https://circleci.com/docs/2.0/runner-overview/)
- [Docker Docs](https://docs.docker.com/)

## Container orchestrators

We support running `launch-agent` in [Kubernetes](https://kubernetes.io/)([docs](https://circleci.com/docs/2.0/runner-on-kubernetes/)). Other container orchestrators are not supported at this time

## License

This repository is licensed under the Apache 2.0 license.
The license can be found [here](./LICENSE).

[runner]: https://github.com/CircleCI-Public/circleci-runner-docker/
[Nomad]: https://www.nomadproject.io/
[AWS Fargate]: https://aws.amazon.com/fargate
