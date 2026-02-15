# ghcr.io/coolcow/strongswan-client

Simple and minimal Alpine-based Docker image for a Strongswan client.

---

## Overview

This image runs `strongswan` and starts an IPsec tunnel based on configuration
files mounted into `/install`.

---

## Usage

### Quick Start

```sh
docker run --rm ghcr.io/coolcow/strongswan-client
```

### Required Mounts

- `/install/ipsec.conf`
- `/install/ipsec.secrets`

### Environment Variables

| Variable | Default | Description |
|---|---:|---|
| `PROFILE_NAME` | `default` | IPsec connection profile name used with `ipsec up/down` |
| `LOCAL_IP` | `127.0.0.1` | Loopback alias added in container (`lo:<PROFILE_NAME>`) |
| `WAIT_AFTER_START` | `10` | Seconds to wait after `ipsec start` before first `ipsec up` |
| `RECONNECT_IF_NOT` | _(empty)_ | Optional command used as reconnect health check |
| `RECONNECT_IF_NOT_INTERVAL` | `10` | Interval in seconds for reconnect check loop |

### Example

```sh
docker run -d --name strongswan-client \
	-v <PATH_TO_IPSEC_CONF>:/install/ipsec.conf:ro \
	-v <PATH_TO_IPSEC_SECRETS>:/install/ipsec.secrets:ro \
	-e PROFILE_NAME=default \
	-e LOCAL_IP=127.0.0.1 \
	ghcr.io/coolcow/strongswan-client
```

---

## References

- [Strongswan](https://www.strongswan.org/)


