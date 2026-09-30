# 08 - CI/CD

Continuous Integration and Continuous Deployment – automate testing and deployment pipelines.

## What You'll Learn

- CI/CD concepts and benefits
- GitHub Actions workflow syntax
- Building and testing in pipelines
- Deploying to various targets
- Secrets management
- Pipeline best practices
- Other CI/CD tools (Jenkins, GitLab CI)

## Folder Structure

```
08-cicd/
├── notes/       # Your notes from lessons
├── labs/        # Completed lab exercises
└── projects/    # Hands-on projects
```

## Suggested Projects

- [ ] Create a CI pipeline that runs tests
- [ ] Build and push Docker images in a pipeline
- [ ] Deploy to AWS from GitHub Actions
- [ ] Set up a multi-environment deployment pipeline

## GitHub Actions Basics

```yaml
# .github/workflows/ci.yml
name: CI

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Node
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run tests
        run: npm test
        
  build:
    needs: test
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Build Docker image
        run: docker build -t myapp:${{ github.sha }} .
```

## Key Concepts

| Term | Meaning |
|------|---------|
| CI | Continuous Integration – automated testing on every commit |
| CD | Continuous Deployment – automated deployment after tests pass |
| Pipeline | Series of automated steps |
| Job | Collection of steps that run on the same runner |
| Step | Individual task within a job |
| Artifact | Files produced by a build |
| Secret | Sensitive data stored securely |

## Best Practices

- Run tests on every PR
- Use caching for dependencies
- Store secrets in GitHub Secrets, never in code
- Use environment-specific deployments
- Add status badges to your README
- Keep pipelines fast

## Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Actions Marketplace](https://github.com/marketplace?type=actions)
