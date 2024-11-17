
FROM debian:bookworm-slim

ARG DEBIAN_FRONTEND=noninteractive 
ARG DEBCONF_NONINTERACTIVE_SEEN=true
ARG S6_VERSION=v2.2.0.3

ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2 \
  SSHD_CONFIG=/etc/ssh/sshd_config \
  NSLCD_CONFIG=/etc/nslcd.conf

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
# NOTE: perl-base for debconf, see: https://unix.stackexchange.com/a/690050
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  openssh-server \
  libnss-ldapd \
  libpam-ldapd \
  perl-base \
  wget \
  debconf-utils \
  && ARCH="$(uname -m)" \
  && if [ "${ARCH}" = "x86_64" ]; then S6_ARCH=amd64; \
  elif [ "${ARCH}" = "i386" ]; then S6_ARCH=X86; \
  elif echo "${ARCH}" | grep -E -q "armv6|armv7"; then S6_ARCH=arm; \
  else S6_ARCH="${ARCH}"; \
  fi \
  && echo using architecture "${S6_ARCH}" for S6 Overlay \
  && wget --quiet -O "s6.tgz" "https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-${S6_ARCH}.tar.gz" \
  && tar xzf "s6.tgz" -C / \
  && rm "s6.tgz" \
  && rm -rf /var/lib/apt/lists/* \
  && rm "${SSHD_CONFIG}" \
  && rm "${NSLCD_CONFIG}" \
  && rm /etc/ssh/ssh_host*

COPY rootfs/ /

EXPOSE 2222

VOLUME /config

ENTRYPOINT ["/init"]
