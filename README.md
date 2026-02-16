# ghcr.io/coolcow/strongswan-client

A minimal Alpine-based Docker image for a [strongSwan](https://www.strongswan.org/) client.

This image starts `strongswan` and brings up an IPsec tunnel using configuration
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
	--cap-add=NET_ADMIN \
	-v <PATH_TO_IPSEC_CONF>:/install/ipsec.conf:ro \
	-v <PATH_TO_IPSEC_SECRETS>:/install/ipsec.secrets:ro \
	-e PROFILE_NAME=default \
	-e LOCAL_IP=127.0.0.1 \
	ghcr.io/coolcow/strongswan-client
```

---

## Configuration

### Build-Time Arguments

Customize the image at build time with `docker build --build-arg <KEY>=<VALUE>`.

| Argument | Default | Description |
| --- | --- | --- |
| `ALPINE_VERSION` | `3.23.3` | Version of the Alpine base image. |
| `ENTRYPOINTS_VERSION` | `2.0.0` | Version of the `coolcow/entrypoints` image used for shared scripts. |

---

## Local Testing

Run the built-in smoke tests locally.

1. `docker build -t ghcr.io/coolcow/strongswan-client:local-test-build -f build/Dockerfile build`
2. `docker build --build-arg APP_IMAGE=ghcr.io/coolcow/strongswan-client:local-test-build -f build/Dockerfile.test build`

---

## References

- [strongSwan](https://www.strongswan.org/)
- [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)

---

## License

GPL-3.0. See [LICENSE.txt](LICENSE.txt) for details.


