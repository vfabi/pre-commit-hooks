# pre-commit-hooks

This repository contains a collection of pre-commit hooks for automating configuration file management tasks and security checks.

## Available Hooks

### configuration_files_templating

This hook is designed for configuration file templating and encryption operations.

### trivy-fs-docker

Hook for scanning the filesystem for security vulnerabilities using [Trivy](https://github.com/aquasecurity/trivy). Runs via Docker.

### trivy-config-docker

Hook for scanning configuration files (IaC) for security issues and misconfigurations using [Trivy](https://github.com/aquasecurity/trivy). Same as `trivy-fs-docker --scanners=misconfig`. Runs via Docker.

### python-bandit

Hook for checking Python code using [Bandit](https://github.com/PyCQA/bandit). A widely-used, open-source SAST tool specifically designed for Python code. It scans for common security issues like hardcoded passwords, SQL injections, and the unsafe use of functions. Runs via Docker.

## Usage

Ensure you have [pre-commit](https://pre-commit.com/) and Docker installed.

To use these hooks, add the following config example to your `.pre-commit-config.yaml`:

```yaml
repos:
  - repo: https://github.com/vfabi/pre-commit-hooks
    rev: <VERSION>  # Specify the version tag or commit hash
    hooks:
      # Custom
      - id: configuration-files-templating
      # Security
      - id: trivy-fs-docker
        args:
          - --skip-dirs=tests/,.git/,.venv/,.mypy_cache/
          - --scanners=vuln,secret,misconfig
          - --severity=HIGH,CRITICAL
          - --helm-kube-version=1.26.0
          - --ignore-unfixed
          - --format=table
          # - --exit-code=0
          - .  # last arg indicates the path/file to scan
      - id: trivy-config-docker
        args:
          - --skip-dirs=tests/
          - --skip-dirs=tmp/
          - --severity=HIGH,CRITICAL
          - --format=table
          - .  # last arg indicates the path/file to scan
      # Python SAST
      - id: python-bandit
        args:
          - -r
          - app # recursively scan the app directory
```
