ARG NVIDIA_IMAGE_VERSION=1.3
FROM registry.redhat.io/rhelai1/bootc-nvidia-rhel9:${NVIDIA_IMAGE_VERSION}

COPY override.conf /etc/systemd/system/bootc-generic-growpart.service.d/override.conf

# The following block requires that your system is registered with subscription-manager
RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %{rhel}).noarch.rpm && \
  sed -i "s/\\\$releasever/$(rpm -E '%{rhel}')/g" /etc/yum.repos.d/epel*.repo && \
  dnf -y --enablerepo=rhceph-8-tools-for-rhel-9-x86_64-rpms install nvtop ceph-common && \
  dnf clean all

RUN curl -sSf -O https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    rm -f get-pip.py
