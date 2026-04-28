# Stage 1: Git

## Goal
Get comfortable with branching, history, and pull request workflows.

## Setup
```bash
git clone https://github.com/YOUR_USERNAME/devops-learning-lab.git
cd devops-learning-lab
```

## Exercises
1. Create a feature branch: `git checkout -b feature/my-first-change`
2. Edit `src/DevOpsLab.Api/Program.cs` — add a new endpoint
3. Stage and commit: `git add . && git commit -m "feat: add greeting endpoint"`
4. Push: `git push origin feature/my-first-change`
5. Open a Pull Request on GitHub — watch CI pipeline trigger automatically

## Key Commands
```bash
git log --oneline --graph --all    # visualise branch history
git stash / git stash pop          # temporarily shelve changes
git rebase main                    # keep branch up to date
git diff HEAD~1                    # see what changed in last commit
```
