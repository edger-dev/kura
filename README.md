# Kura (蔵)

A personal media archive. Kura imports photos and videos as content-addressed,
immutable originals; maintains rich, searchable metadata without ever touching
the originals; composes them into collections; generates lightweight variations
for browsing; and keeps the whole dataset safe across many storage places —
including offline disks.

The name is the Japanese *kura* (蔵): a thick-walled, fireproof storehouse built
to keep a family's treasures safe across generations. That is the goal — originals
preserved forever, protected by redundancy, reachable from anywhere.

## What Kura does

- **Immutable originals** — media enters once, addressed by content hash, and is
  never mutated. New edits are new versions; the original always survives.
- **Metadata, decoupled** — searchable/filterable metadata lives apart from the
  bytes, so it can be edited, annotated, and synced without rewriting originals.
- **Collections** — albums, blog posts, and other groupings, either manually
  curated or dynamically filtered on metadata. Notes attach to a single item or a
  whole collection.
- **Variations** — thumbnails, daily-view proxies, and transcodes, generated as
  derived content with their own storage policies (e.g. thumbnails everywhere,
  raws nowhere on a phone).
- **Multi-place, offline-aware storage** — the same data lives in multiple places;
  cold data as never-change pack files. Offline places (removable disks) are
  tracked and integrity-checked. Selected subsets (e.g. starred) can be backed up
  to extra places for higher reliability.
- **Carry views anywhere** — a device caches the set it needs (a phone might hold
  all thumbnails and starred proxies, never raws) while still making metadata
  edits that sync back.

## Architecture

Kura is a component of [Kudo](https://github.com/edger-dev/kudo) and is built on
the platform's existing layers rather than reinventing them:

```
Moco        — content-addressed byte storage: pluggable backends,
              tiering, location/replication tracking, integrity, dedup
  ↑
Kinora      — identity / versioning / metadata / provenance / kinographs
  ↑
Kura (蔵)   — media kinds, variations, EXIF, import, backup policy + Tsui viewer
```

- **[Moco](https://github.com/edger-dev/moco)** provides the byte substrate. A
  media item's bytes — and every variation's bytes — are content-addressed blobs
  living across pluggable backends (local, S3, removable disk, pack files).
- **[Kinora](https://github.com/edger-dev/kinora)** provides identity and metadata.
  A media item is a *kino*, a collection is a *kinograph*, a note is a linked kino,
  and a starred-subset backup is a kinograph plus a replication policy. Kura depends
  on full Kinora — notes ride its document side.
- **Kura** adds the media domain: media-specific kinds (`kura::photo`, `kura::video`),
  variation pipelines, EXIF extraction, import, and a [Tsui](https://github.com/edger-dev/tsui)
  viewer.

The design rationale lives in
[Kudo RFC-0005: Storage Layering and the Kura Media Archive](https://github.com/edger-dev/kudo/blob/main/docs/src/rfcs/rfc-0005_storage-layering-kura.md).

## Status

Early — design stage. No implementation yet.

## License

MIT
