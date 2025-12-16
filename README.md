# blskeystore

[![License](https://img.shields.io/badge/License-Apache%202.0%20OR%20MIT-blue.svg)](LICENSE-APACHE)
[![Zig](https://img.shields.io/badge/Zig-0.15.2+-orange.svg)](https://ziglang.org/)

A Zig-based command-line tool for generating and managing BLS12-381 v4 keystores compliant with the [EIP-2335](https://eips.ethereum.org/EIPS/eip-2335) specification.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Requirements](#requirements)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)
- [Support](#support)
- [Acknowledgments](#acknowledgments)

## Overview

`blskeystore` provides functionality to:

- Generate new BLS12-381 v4 keystores with secure encryption
- Convert existing keystores between different crypto parameters
- Simplify keystore management for testing environments

This tool is particularly useful for Ethereum validators and developers working with BLS signatures who need to manage keystores or create test keystores with adjusted parameters.

## Features

- **BLS12-381 Support** - Full support for BLS12-381 key generation
- **EIP-2335 Compliant** - Generates v4 keystores following the standard
- **Crypto Conversion** - Modify keystore encryption parameters (KDF, cipher settings)
- **Test-Friendly** - Easily create keystores with reduced parameters for faster testing
- **Cross-Platform** - Built with Zig for portability

## Installation

### From Source

```bash
git clone https://github.com/usmansaleem/blskeystores.git
cd blskeystores
zig build -Doptimize=ReleaseSafe
```

The binary will be available in `zig-out/bin/blskeystore`.

### Pre-built Binaries

Pre-built binaries will be available from the [releases page](https://github.com/usmansaleem/blskeystores/releases) once the first stable version is released.

## Usage

### Generate New Keystores

Generate a single keystore:

```bash
blskeystore generate --count 1 --password "your-secure-password" --output-dir ./keystores
```

Generate multiple keystores:

```bash
blskeystore generate --count 5 --password-file ./password.txt --output-dir ./keystores
```

### Convert Keystores

Convert existing keystores to use lighter parameters (useful for testing):

```bash
blskeystore convert \
  --input-dir ./keystores \
  --output-dir ./light-keystores \
  --password-dir ./passwords \
  --kdf-iterations 1 \
  --kdf-memory 16
```

 ### Command Options

Run `blskeystore --help` for a full list of available commands and options.

## Requirements

- Zig 0.15.2 or later

## Development

### Building

Build the project:

```bash
zig build
```

Build with optimizations:

```bash
zig build -Doptimize=ReleaseSafe
```

### Testing

Run all tests:

```bash
zig build test --summary all
```

### Release Process

1. Update version in `build.zig.zon`
2. Update `CHANGELOG.md` - move `[Unreleased]` entries to new version
3. Commit: `chore: release v0.x.x`
4. Tag: `git tag v0.x.x`
5. Push: `git push && git push --tags`

See [CHANGELOG.md](CHANGELOG.md) for version history.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Commit Messages

This project follows [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for commit messages:

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `test:` - Test additions or modifications
- `refactor:` - Code refactoring
- `chore:` - Maintenance tasks

Example: `feat: add support for scrypt KDF parameters`

### Changelog

All notable changes are documented in [CHANGELOG.md](CHANGELOG.md) following the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format.

When submitting a PR, please add an entry to the `[Unreleased]` section under the appropriate category:

- `Added` for new features
- `Changed` for changes in existing functionality
- `Deprecated` for soon-to-be removed features
- `Removed` for now removed features
- `Fixed` for any bug fixes
- `Security` for vulnerability fixes

### Before Submitting

- Ensure all tests pass: `zig build test --summary all`
- Follow the existing code style
- Add tests for new functionality
- Update CHANGELOG.md with your changes

## License

This project is dual-licensed under:

- [Apache License 2.0](LICENSE-APACHE) - [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)
- [MIT License](LICENSE-MIT) - [http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT)

You may choose either license for your purposes.

## Support

- **Issues**: Report bugs or request features via [GitHub Issues](https://github.com/usmansaleem/blskeystores/issues)
- **Discussions**: For questions and discussions, use [GitHub Discussions](https://github.com/usmansaleem/blskeystores/discussions)

## Acknowledgments

- [EIP-2335](https://eips.ethereum.org/EIPS/eip-2335) - Ethereum BLS12-381 Keystore Specification
- The Zig community for the excellent programming language and tools
- Consensys [Web3Signer](https://github.com/Consensys/web3signer) and [Teku](https://github.com/Consensys/teku)
