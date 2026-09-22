# Changelog

All notable changes to this pipeline are documented here. The version here, the
`PIPELINE_VERSION` in `pipeline/nextflow.config`, and the release tag must agree --
`Processing.pipelines.code.version` is read from the environment variable.

The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and the
versions follow [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-09-22

First versioned release. Transform, resample and packaging, producing one AIND derived
data asset per neuron.

### Added

- Three-stage pipeline: SWC transform into CCF space, resampling of both coordinate
  spaces at 10 um, and per-cell packaging.
- `pipeline/nextflow.config` supplying `PIPELINE_URL`, `PIPELINE_NAME` and
  `PIPELINE_VERSION`, so `Processing.pipelines` records the pipeline rather than a
  fallback default.
- Cost-monitoring resource label `allen-batch-pipeline: exaspim-swc-processing`.
