#!/bin/sh

set -eu

echo "Checking that correct config files have been placed"
stat -t ~/.terraformrc
stat -t ~/.terraform.d/providers/linux_amd64/terraform-provider-cloudfoundry

mkdir -p tmp-test-dir
cd tmp-test-dir || exit
cat << 'EOF' > config.tf
provider "cloudfoundry" {
  api_endpoint = "https://api.local.pcfdev.io"
  username = "admin"
  password = "admin"
  skip_ssl_validation = true
}

data "cloudfoundry_organization" "pcfdev" {
  name = "pcfdev-org"
}

data "cloudfoundry_space" "pcfdev" {
    name = "pcfdev-space"
    org_id = "${data.cloudfoundry_organization.pcfdev.id}"
}

resource "cloudfoundry_service" "uaa-db" {
  name = "uaa-db"
  space_id = "${data.cloudfoundry_space.pcfdev.id}"
  service = "p-mysql"
  plan = "512mb"
}
EOF

cat config.tf

echo "Checking that terraform init succeeds"
terraform init

cd .. && rm -rf tmp-test-dir
