FROM scratch as base

LABEL maintainer="till@lagged.biz"

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
ADD . .

# ensure docker is running
RUN systemctl enable poke-docker

# configure & enable ssh
ADD https://github.com/${GITHUB_USER}.keys /home/core/keys
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
