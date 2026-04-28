# Stage 2: GitHub Actions

## Goal
Automate build, test, and Docker image push on every commit.

## Files
- `.github/workflows/ci.yml` — build + test on every push/PR
- `.github/workflows/cd.yml` — push image to GHCR on main merges

## Exercises
1. Push a commit to `main` — open the **Actions** tab on GitHub and watch it run
2. Introduce a deliberate build error — watch the pipeline fail
3. Fix it — watch it go green again
4. Add a step to `ci.yml` that runs `dotnet format --verify-no-changes`
5. Add a `workflow_dispatch` trigger so you can run it manually from GitHub UI

## Key Concepts
- **Triggers**: `push`, `pull_request`, `schedule`, `workflow_dispatch`
- **GITHUB_TOKEN**: automatic, no setup required — used in `cd.yml` to push images
- **Caching**: `actions/cache@v4` for NuGet packages; saves ~30s per run
- **Secrets**: Settings → Secrets & Variables → Actions
