# exaSPIM SWC processing pipeline

Transforms refined exaSPIM neuron reconstructions into CCF space and publishes one AIND
derived data asset per neuron.

| Stage | Capsule | Does |
|---|---|---|
| transform | [exaspim-swc-transform-capsule](https://github.com/peter-grotz/exaspim-swc-transform-capsule) | specimen space to CCF space |
| resample | [exaspim-swc-resample-capsule](https://github.com/peter-grotz/exaspim-swc-resample-capsule) | 10 um node spacing, both coordinate spaces |
| packaging | [exaspim-swc-packaging-capsule](https://github.com/peter-grotz/exaspim-swc-packaging-capsule) | per-cell layout, `data_description.json`, `processing.json` |

Shared logic lives in [exaspim-swc-processing](https://github.com/peter-grotz/exaspim-swc-processing).

## Layout

`pipeline/main.nf` is **generated** by the Code Ocean pipeline builder and is overwritten
whenever the pipeline is saved in the UI; it carries a `hash:sha256` marker. Do not edit
it by hand. Per-stage CPU and memory are set in the UI and baked into it.

`pipeline/nextflow.config` is hand-written and survives regeneration. It carries the
`PIPELINE_*` variables the packaging capsule reads and the cost-monitoring label.

## Releasing

Bump `PIPELINE_VERSION` in `pipeline/nextflow.config` and add a `CHANGELOG.md` entry in
the same commit, then merge to `main`. The release workflow tags and publishes from
there. Cut a Code Ocean internal release separately; the `MAJOR.0` version Code Ocean
assigns is not the semantic version.
