FROM ljfranklin/terraform-resource

RUN mkdir -p /root/.terraform.d/providers/linux_amd64/

COPY terraform-provider-cloudfoundry /root/.terraform.d/providers/linux_amd64/terraform-provider-cloudfoundry

ADD .terraformrc /root/