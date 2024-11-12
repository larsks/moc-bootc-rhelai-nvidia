ARG NVIDIA_IMAGE_VERSION=1.2
FROM registry.redhat.io/rhelai1/bootc-nvidia-rhel9:${NVIDIA_IMAGE_VERSION}

COPY override.conf /etc/systemd/system/bootc-generic-growpart.service.d/override.conf

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %{rhel}).noarch.rpm && \
  dnf -y install nvtop && \
  dnf clean all

RUN curl -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm -f get-pip.py
