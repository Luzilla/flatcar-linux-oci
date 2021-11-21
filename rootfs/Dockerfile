FROM scratch as base

LABEL maintainer="till@php.net"
LABEL org.opencontainers.image.source=https://github.com/Luzilla/flatcar-linux-oci

ARG GITHUB_USER

USER root
ADD root.tar /

FROM base as clean-up

RUN find /etc/systemd/system \
    /lib/systemd/system \
    -path '*.wants/*' \
    -not -name '*journald*' \
    -not -name '*systemd-tmpfiles*' \
    -not -name '*systemd-user-sessions*' \
    -exec rm \{} \;

RUN systemctl set-default multi-user.target
RUN systemctl mask \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    systemd-update-utmp.service \
    systemd-tmpfiles-setup.service \
    console-getty.service \
    sshd.socket

# poor man's ignition
ADD etc etc

# ensure docker is running
RUN systemctl enable poke-docker

# setup core user
ADD https://github.com/${GITHUB_USER}.keys /home/core/keys
RUN mkdir -p /home/core/.ssh/ \
    && mv /home/core/keys /home/core/.ssh/authorized_keys \
    && chmod 0700 /home/core/.ssh/ \
    && chown -R core:core /home/core \
    # configure and enable sshd
    && chown 0600 /etc/ssh/sshd_config \
    && systemctl enable sshd.service

VOLUME ["/sys/fs/cgroup"]
EXPOSE 22
STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init"]
