# CF Terraform Image

A pipeline and Dockerfile for adding the necessary files to the [Concourse terraform-resource](https://github.com/ljfranklin/terraform-resource) for the [Cloud Foundry terraform provider](https://github.com/orange-cloudfoundry/terraform-provider-cloudfoundry) to work out of the box.

The image is maintained by a Concourse pipeline and will update on new releases of both the Concourse terraform resource and of the CF terraform provider.

## Pulling the image

```sh
docker pull engineerbetter/cf-terraform-image
```
