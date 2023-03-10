# Contributing

When contributing to this repository, please first discuss the change you wish to make via issue,
email, or any other method with the owners of this repository before making a change.

## Pull Request Process

1. Fork the project.
2. Start a feature branch based on the [dev](https://git.source.akamai.com/users/bbrouard/repos/waf_bp_tf/browse?at=refs%2Fheads%2Fdev) branch (`git checkout -b <feature-name> dev`).
3. Update the README.md with details of changes including example hcl blocks and [example files](./examples) if appropriate.
4. Commit and push your changes.
5. Issue a pull request and wait for your code to be reviewed.

## Checklists for contributions

- [ ] Add [semantics prefix](#semantic-pull-requests) to your PR or Commits (at least one of your commit groups)
- [ ] README.md has been updated.

## Semantic Pull Requests

To generate changelog, Pull Requests or Commits must have semantic and must follow conventional specs below:

- `feat:` for new features
- `fix:` for bug fixes
- `improvement:` for enhancements
- `docs:` for documentation and examples
- `refactor:` for code refactoring
- `test:` for tests
- `ci:` for CI purpose
- `chore:` for chores stuff

The `chore` prefix skipped during changelog generation. It can be used for `chore: update changelog` commit message by example.
