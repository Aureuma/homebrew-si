# SI Homebrew Tap

Homebrew tap for the `si` CLI release binaries.

## Installation

```bash
brew tap aureuma/si
brew install si
```

Or install formula directly (no auto-updates from tap):

```bash
brew install https://raw.githubusercontent.com/Aureuma/homebrew-si/main/Formula/si.rb
```

## Usage

```bash
si --help
si version
```

## Supported platforms

- macOS: Apple Silicon (`arm64`), Intel (`amd64`)
- Linux: `arm64`, `amd64`

## Release automation

This tap is updated automatically from SI release workflow (`Aureuma/si`):

- builds and uploads multi-arch release archives
- updates `Formula/si.rb` with new version + SHA256 checksums
- commits and pushes formula updates to this tap

You can also trigger formula updates manually using the workflow in this repo.
