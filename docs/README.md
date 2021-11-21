# Flatcar Linux in an OCI image

Enabled services:

 - dockerd
 - sshd (see [`../rootfs/Dockerfile`](rootfs/Dockerfile))


Examples:
 - [Run Flatcar Linux with Docker](flatcar-in-docker/)
 - [Use Ansible with the dockerized Flatcar](ansible/)


## Customization

In order to add your own SSH key into the mix, you can build with:

```sh
$ make build GITHUB_USER=your-handle
...
```

If `make` is not your thing:

```Dockerfile
FROM ghcr.io/luzilla/flatcar:stable

ADD https://github.com/${GITHUB_USER}.keys /home/core/keys
RUN mkdir -p /home/core/.ssh/ \
    && cat /home/core/keys >> /home/core/.ssh/authorized_keys \
    && rm /home/core/keys \
    && chmod 0700 /home/core/.ssh/ \
    && chown core:core /home/core/.ssh \
```
