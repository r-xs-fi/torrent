Container image for torrent - Full-featured BitTorrent client package and utilities.

## Usage

### Download a torrent

```shell
docker run --rm -it --privileged --network=host --volume=$(pwd):/workspace ghcr.io/r-xs-fi/torrent download magnet:?xt=urn:btih:...
```

Outputs:
```console
136.95µs: getting torrent info for "..."
```
### Pick a file from inside the torrent to download

```shell
docker run --rm -it --privileged --network=host --volume=$(pwd):/workspace ghcr.io/r-xs-fi/torrent download --file=file.mp4 magnet:?xt=urn:btih:...
```

Outputs:
```console
136.95µs: getting torrent info for "..."
```

## Supported platforms


| OS    | Architecture  | Supported | Example hardware |
|-------|---------------|-----------|-------------|
| Linux | amd64 | ✅       | Regular PCs (also known as x64-64) |
| Linux | arm64 | ✅       | Raspberry Pi with 64-bit OS, other single-board computers, Apple M1 etc. |
| Linux | arm/v7 | ✅       | Raspberry Pi with 32-bit OS, older phones |
| Linux | riscv64 | ✅       | More exotic hardware |

## How does this software get to me?

```mermaid
flowchart TD
    subgraph "Origin"
        sourcerepo["Original source repo 🔗"]

        click sourcerepo "https://github.com/anacrolix/torrent"
    end
    subgraph "Full build"
        rxsfi_build["r.xs.fi build (GitHub Actions)"]
    end
    subgraph "Container Registry"
        r_xs_fi_package_registry[ghcr.io/r-xs-fi/torrent 🔗]

        click r_xs_fi_package_registry "https://ghcr.io/r-xs-fi/torrent"
    end
    subgraph "user"
        docker_run[$ docker run ...]
    end
    sourcerepo -- download source code --> rxsfi_build
    rxsfi_build -- push --> r_xs_fi_package_registry
    r_xs_fi_package_registry -- pull --> docker_run[$ docker run ...]

```
