# CF Terraform Image

A pipeline and Dockerfile for adding the necessary files to the [Concourse terraform-resource](https://github.com/ljfranklin/terraform-resource) for the [Cloud Foundry terraform provider](https://github.com/mevansam/terraform-provider-cf) to work out of the box.

The image is maintained by a Concourse pipeline and will update on new releases of both the Concourse terraform resource and of the CF terraform provider.

## Pulling the image

```sh
docker pull engineerbetter/cf-terraform-image
```

## Using the image in a Concourse pipeline

You can use this image in the same way as you would use the standard [terraform resource](https://github.com/ljfranklin/terraform-resource)

### Partial pipeline:

```yaml
resource_types:
- name: terraform
  type: docker-image
  source:
    repository: engineerbetter/cf-terraform-image

resources:
- name: cf-tf
  type: terraform
  source:
    storage:
      bucket: ((tf_bucket_name))
      bucket_path: ((tf_bucket_path))
      region_name: ((bucket_region))
      access_key_id: ((s3_access_key))
      secret_access_key: ((s3_secret_key))
    env:
      HOME: /root

jobs:
- name: terraform-cf
  plan:
  - get: tf-source
    trigger: true
  - put: cf-tf
    params:
      terraform_source: tf-source/terraform/
```

*Note:* The `HOME` environment variable in the resource source is required because the image for this resource keeps its `.terraformrc` in `/root` and terraform looks for it in `~`. By default the standard terraform resource does not set a specific value for `$HOME` and environment values defined in the docker image are not passed to terraform in the same way as variables provided through the resource source.

### Example provider block

```hcl
provider "cf" {
  api_endpoint = "https://api.local.pcfdev.io"
  username = "admin"
  password = "admin"
  skip_ssl_validation = true
}
```
