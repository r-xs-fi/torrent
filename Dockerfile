# `--platform` to always compile on builder native platform for speed (Go is good at cross-compiling)
FROM --platform=$BUILDPLATFORM fn61/buildkit-golang:20260604_1344_ff654e98 AS builder

ARG TARGETOS
ARG TARGETARCH

RUN cd / && git clone --recurse-submodules https://github.com/anacrolix/torrent.git

RUN --mount=type=cache,id=gomodcache,target=/go/pkg/mod,sharing=locked \
    --mount=type=cache,id=gobuildcache,target=/root/.cache/go-build,sharing=locked \
    cd /torrent/cmd/torrent && GOARCH=$TARGETARCH CGO_ENABLED=0 go build -ldflags "-extldflags \"-static\"" && \
    cd /torrent/cmd/torrent-pick && GOARCH=$TARGETARCH CGO_ENABLED=0 go build -ldflags "-extldflags \"-static\""

#  ▲               runtime ──┐
#  └── build                 ▼

RUN mkdir /tmp/tmpdir && chown 1000:1000 /tmp/tmpdir

FROM scratch

WORKDIR /workspace

ENTRYPOINT ["/usr/bin/torrent"]

CMD ["download"]

# dummy command to make dir /tmp (torrent-pick needs /tmp dir to be present)
COPY --from=builder --chmod=777 /tmp/tmpdir /tmp

COPY --from=builder /torrent/cmd/torrent/torrent /torrent/cmd/torrent-pick/torrent-pick /usr/bin/

USER 1000:1000
