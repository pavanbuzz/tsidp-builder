# tsidp Auto-Builder Setup Guide

This guide will help you set up automatic building and releasing of the `tsidp` binary from Tailscale releases.

## Prerequisites

1. A GitHub repository where you'll store this workflow
2. GitHub Actions enabled on your repository
3. Appropriate permissions to create releases

## Setup Steps

### 1. Create Repository Structure

```bash
mkdir tsidp-builder
cd tsidp-builder
git init
```

### 2. Add the Workflow File

Create the directory structure:
```bash
mkdir -p .github/workflows
```

Copy the `build-tsidp.yml` file to `.github/workflows/build-tsidp.yml`

### 3. Configure Repository Settings

#### Enable GitHub Actions
- Go to your repository settings
- Navigate to "Actions" → "General"
- Ensure "Allow all actions and reusable workflows" is selected

#### Set Permissions
- In the same Actions settings page
- Under "Workflow permissions"
- Select "Read and write permissions"
- Check "Allow GitHub Actions to create and approve pull requests"

### 4. Repository Secrets (if needed)

The workflow uses `GITHUB_TOKEN` which is automatically provided. No additional secrets are needed for basic functionality.

### 5. Initial Commit and Push

```bash
git add .
git commit -m "Initial commit: Add tsidp auto-builder workflow"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/tsidp-builder.git
git push -u origin main
```

## How It Works

### Automatic Triggering
- **Daily Check**: Runs daily at 6 AM UTC to check for new Tailscale releases
- **Manual Trigger**: You can manually run the workflow from the Actions tab
- **Push Trigger**: Runs when you push to the main branch (for testing)

### Build Process
1. Checks if there's a new Tailscale release
2. If found, builds `tsidp` for multiple platforms:
   - Linux (amd64, arm64)
   - macOS (amd64, arm64)
   - Windows (amd64)
3. Creates a new release with all binaries

### Release Format
- **Tag**: `tsidp-v1.x.x` (matches Tailscale version)
- **Assets**: Multiple platform-specific binaries
- **Description**: Includes build information and usage instructions

## Usage After Setup

### Download Binaries
1. Go to your repository's Releases page
2. Download the appropriate binary for your platform
3. Make it executable: `chmod +x tsidp-*` (Unix systems)

### Manual Trigger
- Go to Actions tab in your repository
- Click "Build and Release tsidp"
- Click "Run workflow"

### Monitor Builds
- Check the Actions tab for build status
- View logs if builds fail
- Releases appear automatically when successful

## Customization Options

### Change Build Schedule
Edit the cron expression in the workflow:
```yaml
schedule:
  - cron: '0 6 * * *'  # Daily at 6 AM UTC
```

### Add More Platforms
Add entries to the matrix in the workflow:
```yaml
matrix:
  include:
    - goos: freebsd
      goarch: amd64
```

### Modify Binary Name
Change the build command in the workflow:
```bash
go build -ldflags="-s -w" -o custom-name-${{ matrix.goos }}-${{ matrix.goarch }} ./cmd/tsidp
```

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure workflow permissions are set correctly
2. **Build Failures**: Check Go version compatibility
3. **Release Creation Failed**: Verify GITHUB_TOKEN permissions

### Debug Steps
1. Check Actions tab for detailed logs
2. Run workflow manually to test
3. Verify repository permissions

### Getting Help
- Check GitHub Actions documentation
- Review Tailscale build requirements
- Look at workflow run logs for specific errors
