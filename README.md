# Deploy and Host PeerTube on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/peertube?utm_medium=integration&utm_source=button&utm_campaign=peertube)

[PeerTube](https://joinpeertube.org/) is the leading free and open source, decentralized video platform — your own YouTube: upload videos, transcode them to multiple resolutions with HLS, stream live via RTMP, build channels and playlists, and optionally federate with thousands of other PeerTube instances over ActivityPub.

## About Hosting PeerTube

This template runs PeerTube as three Railway services: the PeerTube server (Node.js, serving the web client, API, and HLS video from one container), PostgreSQL, and Redis for job queues. Videos, thumbnails, and admin-panel configuration persist on a single volume at `/data`. RTMP live-streaming ingest is exposed through a Railway TCP proxy on port 1935. The admin `root` account is created on first boot from the `PT_INITIAL_ROOT_PASSWORD` variable. Transcoding runs on CPU via the bundled ffmpeg.

## Common Use Cases

- Personal or creator-owned video hosting with no ads and full data ownership
- Community/company video portal with channels, playlists, and user accounts
- Federated instance connected to the wider PeerTube/Fediverse network
- Live streaming to your own audience via OBS

## Dependencies for PeerTube Hosting

- All bundled: PostgreSQL 17 and Redis are provisioned by the template

### Deployment Dependencies

- [PeerTube documentation](https://docs.joinpeertube.org/)
- [Template source on GitHub](https://github.com/nomideusz/peertube-railway)

### Implementation Details

**Your instance is the `peertube` service's Railway domain.** Log in with username `root` and the `PT_INITIAL_ROOT_PASSWORD` variable's value, then change it in your account settings.

To live stream (after enabling Live in Administration → Configuration → Live streaming):

1. Create a live video in the UI to get your stream key.
2. Add a TCP proxy to the service: Settings → Networking → TCP Proxy → application port `1935`.
3. In OBS set Server to `rtmp://<proxy-host>:<proxy-port>/live` and paste the stream key.

Notes and limits:

- **Transcoding is CPU-only** (Railway has no GPU) — expect roughly real-time or slower encodes for HD; reduce enabled resolutions in the admin panel to lighten the load.
- Media lives on the `/data` volume; volume size is plan-dependent on Railway. For larger libraries, PeerTube supports S3-compatible object storage (Railway buckets work) via `PEERTUBE_OBJECT_STORAGE_*` variables.
- Redis is intentionally ephemeral: a restart loses only queued-but-unstarted transcode jobs, which can be re-run from the admin.
- Federation works out of the box on the Railway domain; if you attach a custom domain later, set `PEERTUBE_WEBSERVER_HOSTNAME` accordingly **before** federating — the hostname is your instance's federated identity.
- To send email (user registration, password resets), set the `PEERTUBE_SMTP_*` variables.

## Why Deploy PeerTube on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying PeerTube on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
