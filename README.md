# Simple SCA Scanner

This repository automates software composition analysis (SCA) scans on GitHub-hosted projects. It could easily be used as a starting point for other git-based hosting services.

## Overview

 - `Dockerfile` sets up a scanning environment with tools like Syft, Grype, and Semgrep.
 - `dev-run.sh` builds and runs the development Docker container.
 - `scan.sh` clones repos and runs Syft scans, then uploads CycloneDX results to a Dependency Track instance.
 - `semgrep_scan.sh` clones repos and runs Semgrep scans in SARIF format.

### Usage

Set needed variables in your environment:
GITHUB_PAT = A Github personal access token for cloning repos
DEPTRACK_API_KEY = An API key for your OWASP Dependency Track instance. See https://github.com/DependencyTrack/dependency-track to set up a simple instance using Docker Compose or similar. 

Build and run the dev container:

`./dev-run.sh repo_list`

Run scans on a repository or a file containing multiple repository URLs:

```bash
# Single repo
docker exec -it sca-scanner-dev /app/scan.sh https://github.com/org/repo.git

# List of repos
docker exec -it sca-scanner-dev /app/scan.sh repo_list
```

The script expects a text file containing one repository URL per line.
Outputs are saved in a “reports” directory after each scan.
Modify scan.sh or semgrep_scan.sh to tailor scanning commands.