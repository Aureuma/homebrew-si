# Repo Rules

- Follow the shared workspace rules in `/home/shawn/Development/AGENTS.md`.
- Keep every `tickets/` directory and all files beneath it ignored by Git. Do not add, force-add, or commit ticket files to version control.

## Secrets And Credentials

- `si fort` is the canonical interface for secret and credential management for this repo. Use raw `si vault` only for explicit Fort/SI Vault maintenance or required local encryption work under the shared workspace rules.

## Version Source Of Truth

- Keep one repo-wide version for the `homebrew-si` tap repository itself.
- The canonical hard-coded version source for the repo is `VERSION` at the repo root.
- Formula release versions are upstream SI release metadata and are not the tap repository version line.
- Every commit that changes tracked content in this repo must bump the patch version in `VERSION` in the same commit.
