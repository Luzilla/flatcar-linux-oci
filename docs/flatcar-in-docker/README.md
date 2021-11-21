# Flatcar Linux in Docker

In the root of this repository, you run `make dev` and then `make shell` in another terminal. To shut it down, execute `sudo shutdown -r now` (inside the `make shell` session).

Details/sample output below:


```sh
$ make dev CHANNEL=stable GITHUB_USER=your-handle

...

 => => exporting layers                                                                                                                                                                          0.0s
 => => writing image sha256:03443469ec70e11e2531218b86e8181c094fce5e6408591ea14c18459bf51b8f                                                                                                     0.0s
 => => naming to ghcr.io/luzilla/flatcar:dev                                                                                                                                                     0.0s
 => => naming to ghcr.io/luzilla/flatcar:stable                                                                                                                                                  0.0s
 => => naming to ghcr.io/luzilla/flatcar:stable-amd64                                                                                                                                            0.0s

Welcome to Flatcar Container Linux by Kinvolk 2983.2.0 (Oklo)!

[  OK  ] Reached target Paths.
[  OK  ] Reached target Slices.
[  OK  ] Reached target Swap.
[  OK  ] Reached target Verify torcx succeeded.
[  OK  ] Listening on Journal Audit Socket.
[  OK  ] Listening on Journal Socket (/dev/log).
[  OK  ] Listening on Journal Socket.
[  OK  ] Listening on udev Control Socket.
[  OK  ] Listening on udev Kernel Socket.
         Starting Journal Service...
         Starting Remount Root and Kernel File Systems...
         Starting Create Static Device Nodes in /dev...
         Starting Wait for udev To Complete Device Initialization...
[  OK  ] Finished Remount Root and Kernel File Systems.
[  OK  ] Finished Create Static Device Nodes in /dev.
         Starting Rule-based Manager for Device Events and Files...
[  OK  ] Started Journal Service.
[  OK  ] Started Rule-based Manager for Device Events and Files.
[  OK  ] Finished Wait for udev To Complete Device Initialization.
         Starting Activation of LVM2 logical volumes...
[  OK  ] Finished Activation of LVM2 logical volumes.
         Starting Activation of LVM2 logical volumes...
[  OK  ] Finished Activation of LVM2 logical volumes.
...
```

Open another terminal:

```sh
$ make shell
...
Password authentication is disabled to avoid man-in-the-middle attacks.
Keyboard-interactive authentication is disabled to avoid man-in-the-middle attacks.
Update Strategy: No Reboots
Failed to connect to bus: No such file or directory
core@1bab695e8843 ~ $ uname -a
Linux 1bab695e8843 5.10.47-linuxkit #1 SMP Sat Jul 3 21:51:47 UTC 2021 x86_64 Intel(R) Core(TM) i7-1060NG7 CPU @ 1.20GHz GenuineIntel GNU/Linux
core@1bab695e8843 ~ $ cat /etc/os-release 
NAME="Flatcar Container Linux by Kinvolk"
ID=flatcar
ID_LIKE=coreos
VERSION=2983.2.0
VERSION_ID=2983.2.0
BUILD_ID=2021-11-05-1835
PRETTY_NAME="Flatcar Container Linux by Kinvolk 2983.2.0 (Oklo)"
ANSI_COLOR="38;5;75"
HOME_URL="https://flatcar-linux.org/"
BUG_REPORT_URL="https://issues.flatcar-linux.org"
FLATCAR_BOARD="amd64-usr"
core@1bab695e8843 ~ $ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
