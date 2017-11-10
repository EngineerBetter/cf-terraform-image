FROM ljfranklin/terraform-resource

# The terraform resource doesn't set HOME by default but
# third party providers need to be able to find .terraformrc
# in ~
ENV HOME /root

RUN mkdir -p /root/.terraform.d/providers/linux_amd64/

COPY terraform-provider-cloudfoundry /root/.terraform.d/providers/linux_amd64/terraform-provider-cloudfoundry

RUN chmod +x /root/.terraform.d/providers/linux_amd64/terraform-provider-cloudfoundry

ADD .terraformrc /root/

# Verify image
COPY verify_image.sh /tmp/verify_image.sh
RUN /tmp/verify_image.sh && rm /tmp/verify_image.sh
