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
