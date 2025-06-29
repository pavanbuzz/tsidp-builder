#!/bin/bash
set -e

echo "🚀 Setting up tsidp auto-builder repository..."

# Create repository structure
mkdir -p tsidp-builder/.github/workflows
cd tsidp-builder

# Copy workflow file
cp ../build-tsidp.yml .github/workflows/

# Copy setup guide
cp ../SETUP.md .

# Create README
cat > README.md << 'EOL'
# tsidp Auto-Builder

Automatically builds and releases the `tsidp` binary from Tailscale whenever new versions are released.

## What is tsidp?

`tsidp` is a Tailscale Identity Provider (IdP) tool that's part of the Tailscale codebase. This repository automatically builds and releases it as a standalone binary.

## Quick Download

Go to the [Releases](../../releases) page to download the latest `tsidp` binary for your platform.

## Setup

See [SETUP.md](SETUP.md) for detailed setup instructions.

## Supported Platforms

- Linux (amd64, arm64)
- macOS (amd64, arm64)
- Windows (amd64)

## How it works

This repository uses GitHub Actions to:
1. Check daily for new Tailscale releases
2. Build the `tsidp` binary for multiple platforms
3. Create a new release with downloadable binaries

## Usage

After downloading:

```bash
# Make executable (Unix systems)
chmod +x tsidp-*

# Run
./tsidp-* --help
```
EOL

# Initialize git
git init
git add .
git commit -m "Initial commit: Add tsidp auto-builder workflow"

echo "✅ Repository structure created!"
echo ""
echo "Next steps:"
echo "1. Create a GitHub repository called 'tsidp-builder'"
echo "2. Add remote: git remote add origin https://github.com/YOUR_USERNAME/tsidp-builder.git"
echo "3. Push: git push -u origin main"
echo "4. Configure repository settings (see SETUP.md)"
echo ""
echo "The workflow will then automatically:"
echo "- Check daily for new Tailscale releases"
echo "- Build tsidp binaries for multiple platforms"
echo "- Create releases you can download"
