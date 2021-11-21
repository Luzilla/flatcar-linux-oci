# Dockerized Flatcar with Ansible

Use the [`Makefile`](../../Makefile) in the root of the repository to sart a docker container called `flatcar` in one terminal: `make dev`

Open a new terminal, change into `docs/ansible` and run Ansible:

```
$ ansible-playbook -i flatcar, playbook.yml
 ____________ 
< PLAY [all] >
 ------------ 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

 ______________________________ 
< TASK [fetch /etc/os-release] >
 ------------------------------ 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

changed: [flatcar]
 ________________________________ 
< TASK [display /etc/os-release] >
 -------------------------------- 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

ok: [flatcar] => {
    "_info.stdout": "NAME=\"Flatcar Container Linux by Kinvolk\"\nID=flatcar\nID_LIKE=coreos\nVERSION=2983.2.0\nVERSION_ID=2983.2.0\nBUILD_ID=2021-11-05-1835\nPRETTY_NAME=\"Flatcar Container Linux by Kinvolk 2983.2.0 (Oklo)\"\nANSI_COLOR=\"38;5;75\"\nHOME_URL=\"https://flatcar-linux.org/\"\nBUG_REPORT_URL=\"https://issues.flatcar-linux.org\"\nFLATCAR_BOARD=\"amd64-usr\"\n"
}
 ____________ 
< PLAY RECAP >
 ------------ 
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

flatcar                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
