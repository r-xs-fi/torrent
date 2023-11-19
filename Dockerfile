FROM --platform=linux/amd64 fn61/buildkit-golang:20230219_1208_a7139a03 AS builder

ARG TARGETOS
ARG TARGETARCH


RUN cd / && git clone https://github.com/anacrolix/torrent.git

RUN cd /torrent/cmd/torrent && GOARCH=$TARGETARCH CGO_ENABLED=0 go build -ldflags "-extldflags \"-static\""

RUN cd /torrent/cmd/torrent-pick && GOARCH=$TARGETARCH CGO_ENABLED=0 go build -ldflags "-extldflags \"-static\""

RUN mkdir /tmp/tmpdir && chown 1000:1000 /tmp/tmpdir

FROM scratch

WORKDIR /workspace

ENTRYPOINT ["/usr/bin/torrent"]

CMD ["download"]

# dummy command to make dir /tmp (torrent-pick needs /tmp dir to be present)
COPY --from=builder --chmod=777 /tmp/tmpdir /tmp

COPY --from=builder /torrent/cmd/torrent/torrent /torrent/cmd/torrent-pick/torrent-pick /usr/bin/

# running as unprivileged user not possible because:
#   file permissions and internal working not yet worked out how-to
