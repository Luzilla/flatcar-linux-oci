FROM scratch as base

LABEL maintainer="till@lagged.biz"

ARG GITHUB_USER

USER root
ADD build/root.tar /

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
RUN mkdir -p /etc/docker/ \
	&& ls -lah /etc/docker/
ADD ignition/daemon.json /etc/docker/daemon.json
ADD ignition/10-debug.conf /etc/systemd/system/systemd-networkd.service.d/10-debug.conf
ADD ignition/poke-docker.service /etc/systemd/system/poke-docker.service
ADD ignition/update.conf /etc/flatcar/update.conf

# ensure docker is running
RUN systemctl enable poke-docker

# configure & enable ssh
ADD https://github.com/${GITHUB_USER}.keys /home/core/keys
ADD ignition/sshd_config /etc/ssh/sshd_config
RUN mkdir -p /home/core/.ssh/ \
    && cat /home/core/keys >> /home/core/.ssh/authorized_keys \
    && rm /home/core/keys \
    && chmod 0700 /home/core/.ssh/ \
    && chown core:core /home/core/.ssh \
    && chown 0600 /etc/ssh/sshd_config \
    && systemctl enable sshd.service

VOLUME ["/sys/fs/cgroup"]
EXPOSE 22
STOPSIGNAL SIGRTMIN+3

CMD ["/sbin/init"]
