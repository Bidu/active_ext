# Folder Structure

## Project Root

| Directory / File | Description |
|-----------------|-------------|
| `lib/` | Gem source code: the `darthjee/active_ext` entry point and version, plus the `active_record/` extensions (`relation_ext.rb`, `base_ext.rb`). |
| `spec/` | RSpec test suite. `spec/lib/` mirrors `lib/`; `spec/support/` holds the test schema, models and shared examples. |
| `config/` | Tooling config: `check_specs.yml` (files exempt from spec coverage), `yardstick.yml`/`yardstick.rb` (YARD docs quality), `rubycritc.rb` (RubyCritic). |
| `docs/agents/` | Agent docs: architecture, flow, folder structure, issue specs and implementation plans. |
| `.github/` | Copilot instructions, PR and commit message templates, and `active_ext-usage.md` (a usage guide for projects that use the gem). |
| `.circleci/` | CircleCI pipeline config. |
| `active_ext.gemspec` | Gem spec (published as `darthjee-active_ext`). |
| `Gemfile` | Development dependencies. |
| `Rakefile` | Rake tasks (YARD/yardstick measurement, etc.). |
| `Dockerfile` / `docker-compose.yml` / `Makefile` | Docker dev environment; `make dev` opens a shell, and the `test_all` service runs specs and the docs checks. |
| `.rubocop.yml` / `.rubocop_todo.yml` | RuboCop lint config. |
| `AGENTS.md` / `CLAUDE.md` | Agent instructions (`CLAUDE.md` points to `AGENTS.md`). |
