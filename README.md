# 🐋 + 📁 + 👤 guillaumedsde/ssh-ldap

[![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/guillaumedsde/ssh-ldap)](https://gitlab.com/guillaumedsde/ssh-ldap/-/pipelines)
[![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/guillaumedsde/ssh-ldap)](https://gitlab.com/guillaumedsde/ssh-ldap/-/pipelines)
[![Website](https://img.shields.io/website?label=documentation&url=https%3A%2F%2Fguillaumedsde.gitlab.io%2Fssh-ldap%2F)](https://guillaumedsde.gitlab.io/ssh-ldap/)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/guillaumedsde/ssh-ldap?label=version)](https://github.com/guillaumedsde/ssh-ldap/releases)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/6bc4aed4e9a64e5ca3e86a39c8fe2a34)](https://www.codacy.com/manual/guillaumedsde/ssh-ldap?utm_source=gitlab.com&utm_medium=referral&utm_content=guillaumedsde/ssh-ldap&utm_campaign=Badge_Grade)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/guillaumedsde/ssh-ldap)](https://hub.docker.com/r/guillaumedsde/ssh-ldap)
[![Docker Pulls](https://img.shields.io/docker/pulls/guillaumedsde/ssh-ldap)](https://hub.docker.com/r/guillaumedsde/ssh-ldap)
[![GitHub stars](https://img.shields.io/github/stars/guillaumedsde/ssh-ldap?label=Github%20stars)](https://github.com/guillaumedsde/ssh-ldap)
[![GitHub watchers](https://img.shields.io/github/watchers/guillaumedsde/ssh-ldap?label=Github%20Watchers)](https://github.com/guillaumedsde/ssh-ldap)
[![Docker Stars](https://img.shields.io/docker/stars/guillaumedsde/ssh-ldap)](https://hub.docker.com/r/guillaumedsde/ssh-ldap)
[![GitHub](https://img.shields.io/github/license/guillaumedsde/ssh-ldap)](https://github.com/guillaumedsde/ssh-ldap/blob/master/LICENSE.md)

Debian bullseyes based docker image for SAMBA with ldap authentication.

This image is based on the work of [`andrespp/docker-ssh-ldap`](https://www.github.com/andrespp/docker-ssh-ldap).

## 🏁 How to Run

### `docker run`

```bash
$ docker run  -v /path/to/nslcd.conf:/etc/nslcd.conf:ro \
              -v /path/to/smb.conf:/etc/ssh/smb.conf:ro \
              -v /etc/localtime:/etc/localtime:ro \
              -e "SSHD_LDAP_PASSWORD=${LDAP_ADMIN_PASSWORD}" \
              -e S6_READ_ONLY_ROOT=1 \
              -p 139:139 \
              -p 445:445 \
              --read-only \
              --tmpfs /run/sshd \
              --tmpfs /var:rw,exec \
              guillaumedsde/guillaumedsde/ssh-ldap:latest
```

### `docker-compose.yml`

```yaml
version: "3.3"
services:
  guillaumedsde:
    volumes:
      - "/path/to/nslcd.conf:/etc/nslcd.conf:ro"
      - "/path/to/smb.conf:/etc/ssh/smb.conf:ro"
      - "/etc/localtime:/etc/localtime:ro"
    read_only: true
    tmpfs:
      - /run/sshd
      - /var:rw,exec
    environment:
      SAMBA_LDAP_PASSWORD: "${LDAP_ADMIN_PASSWORD}"
      S6_READ_ONLY_ROOT: "1"
    ports:
      - "139:139"
      - "445:445"
    image: "guillaumedsde/guillaumedsde/ssh-ldap:latest"
```

## 🖥️ Supported architectures

This container is built for many hardware platforms (yes, even ppc64le whoever uses that... 😉):

- linux/386
- linux/amd64
- linux/arm/v6
- linux/arm/v7
- linux/arm64
- linux/ppc64le

All you have to do is use a recent version of docker and it will pull the appropriate version of the image [guillaumedsde/ssh-ldap](https://hub.docker.com/repository/docker/guillaumedsde/ssh-ldap) from the docker hub.

## 🙏 Credits

A couple of projects really helped me out while developing this container:

- 💽 [`andrespp/docker-samba-ldap`](https://www.github.com/andrespp/docker-samba-ldap) for helpful inspiration
- 🏁 [s6-overlay](https://github.com/just-containers/s6-overlay) A simple, relatively small yet powerful set of init script for managing processes (especially in docker containers)
- 🐋 The [Docker](https://github.com/docker) project (of course)
