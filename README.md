# CircleCI runner images

`circleci/runner` image is created by CircleCI to be with the [runner][] feature.

Currently the `launch-agent` tag can be used to run the launch-agent in a container colocated with the CircleCI job, i.e. the job will run inside the same container.

In the future a variant will be added that runs the `launch-agent` runs on the host and will run each job inside its own container (via the `task-agent`).

## Getting Started

This image can be used a host with docker installed:

```bash
CIRCLECI_RESOURCE_CLASS=<resource-class> CIRCLECI_API_TOKEN=<runner-token> docker run --env CIRCLECI_API_TOKEN --env CIRCLECI_RESOURCE_CLASS --name <container-name> circleci/runner:launch-agent
```

## Contributing

We encourage [issues](https://github.com/CircleCI-Public/runner-preview-docs/issues) and [pull requests](https://github.com/CircleCI-Public/runner-preview-docs/pulls) against this repository.

## Additional Resources

- [CircleCI Docs](https://circleci.com/docs/) - The official CircleCI Documentation website.
- [Runner Preview Docs][runner]
- [Docker Docs](https://docs.docker.com/)

## Container orchestrators

We currently do not support orchestrators such as [Nomad][] or [AWS Fargate][] natively, although `circleci/runner` can be used as a base to develop a custom solution.

## License

This repository is licensed under the MIT license.
The license can be found [here](./LICENSE).

[runner]: https://github.com/CircleCI-Public/runner-preview-docs/
[Nomad]: https://www.nomadproject.io/
[AWS Fargate]: https://aws.amazon.com/fargate
