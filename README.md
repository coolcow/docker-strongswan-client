# ghcr.io/coolcow/strongswan-client

A minimal Alpine-based Docker image for a [strongSwan](https://www.strongswan.org/) client.

This image starts `strongswan` and brings up an IPsec tunnel using configuration
files mounted into `/install`.

The image runs with configurable runtime user/group settings via `su-exec` entrypoint scripts from [docker-entrypoints](https://github.com/coolcow/docker-entrypoints) and can be tuned with build-time version arguments.

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
| `STRONGSWAN_UID` | `0` | User ID used by the entrypoint wrapper (`TARGET_UID`). |
| `STRONGSWAN_GID` | `0` | Group ID used by the entrypoint wrapper (`TARGET_GID`). |
| `STRONGSWAN_REMAP_IDS` | `0` | Set `1` to enable remapping conflicting UID/GID entries (`TARGET_REMAP_IDS`). |
| `STRONGSWAN_USER` | `root` | Runtime user name used by the entrypoint wrapper (`TARGET_USER`). |
| `STRONGSWAN_GROUP` | `root` | Runtime group name used by the entrypoint wrapper (`TARGET_GROUP`). |
| `STRONGSWAN_HOME` | `/root` | Runtime home used by the entrypoint wrapper (`TARGET_HOME`). |
| `STRONGSWAN_SHELL` | `/bin/sh` | Login shell used by the entrypoint wrapper (`TARGET_SHELL`). |
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
	-e STRONGSWAN_UID=$(id -u) \
	-e STRONGSWAN_GID=$(id -g) \
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
| `ENTRYPOINTS_VERSION` | `2.2.0` | Version of the `coolcow/entrypoints` image used for shared scripts. |

---

## Migration Notes

Runtime user/group environment variables are standardized to image-specific `STRONGSWAN_*` names.

- `PUID` → `STRONGSWAN_UID`
- `PGID` → `STRONGSWAN_GID`
- `ENTRYPOINT_USER` → `STRONGSWAN_USER`
- `ENTRYPOINT_GROUP` → `STRONGSWAN_GROUP`
- `ENTRYPOINT_HOME` → `STRONGSWAN_HOME`

Update your `docker run` / `docker-compose` environment configuration accordingly when upgrading from older tags.

---

## Local Testing

Run the built-in smoke tests locally.

1. `docker build -t ghcr.io/coolcow/strongswan-client:local-test-build -f build/Dockerfile build`
2. `docker build -f build/Dockerfile.test build`

---

## References

- [strongSwan](https://www.strongswan.org/)
- [docker-entrypoints](https://github.com/coolcow/docker-entrypoints)

---

## License

GPL-3.0. See [LICENSE.txt](LICENSE.txt) for details.


