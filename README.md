# OpenRouter Homebrew Tap

This repository contains Homebrew formulae for OpenRouter tools.

Homebrew exposes this repository as the `OpenRouterTeam/tap` tap.

## Repository layout

- `Formula/` contains the Homebrew formulae.
- `templates/` contains the binary formula template.
- `scripts/new-formula` creates a formula from release metadata.
- `scripts/check` checks the repository and its formulae.

## Requirements

Install Homebrew and Ruby before you change this repository.

## Create a formula

Build two macOS release archives before you run this command. Each archive must contain one executable at its root.

Run this command with immutable HTTPS URLs and SHA-256 checksums:

```sh
scripts/new-formula \
  <name> \
  <version> \
  <arm64-url> \
  <arm64-sha256> \
  <x86_64-url> \
  <x86_64-sha256>
```

The command creates `Formula/<name>.rb`. Edit the description and homepage after the command completes.

The generated test expects `<name> --version` to print the release version. Change the test if the tool uses a different command.

## Check the tap

Run all local checks:

```sh
scripts/check
```

The check stops if a formula has invalid Ruby syntax or Homebrew style errors.

If this checkout is registered as `OpenRouterTeam/tap`, the check also runs a strict Homebrew audit.

## Test a formula locally

Install the formula from its file:

```sh
brew install --formula ./Formula/<name>.rb
brew test ./Formula/<name>.rb
```

Remove the local installation after the test:

```sh
brew uninstall <name>
```

## Installation

Add the tap and install a formula:

```sh
brew tap OpenRouterTeam/tap
brew install <name>
```

## Release checklist

1. Publish immutable ARM64 and x86-64 macOS archives.
2. Calculate a SHA-256 checksum for each archive.
3. Create or update the formula.
4. Run `scripts/check`.
5. Install and test the formula on both macOS architectures.
6. Get approval from the DevEx team.
7. Merge the formula change.

## Security

A Homebrew formula runs code on user computers. Treat each formula change as a privileged software-distribution change.

Do not put tokens, signed URLs, or other secrets in a formula. Use immutable artifact URLs and pinned checksums.
