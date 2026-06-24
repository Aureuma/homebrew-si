# Repo Rules

## Version Source Of Truth

- Keep one repo-wide version for the `homebrew-si` tap repository itself.
- The canonical hard-coded version source for the repo is `VERSION` at the repo root.
- Formula release versions are upstream SI release metadata and are not the tap repository version line.
- Every commit that changes tracked content in this repo must bump the patch version in `VERSION` in the same commit.
