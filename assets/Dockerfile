FROM ljfranklin/terraform-resource

RUN mkdir -p /root/.terraform.d/providers/linux_amd64/

COPY terraform-provider-cf /root/.terraform.d/providers/linux_amd64/terraform-provider-cf

RUN chmod +x /root/.terraform.d/providers/linux_amd64/terraform-provider-cf

ADD .terraformrc /root/

# Verify image
COPY verify_image.sh /tmp/verify_image.sh
RUN /tmp/verify_image.sh && rm /tmp/verify_image.sh
