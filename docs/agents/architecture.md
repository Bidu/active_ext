# Architecture

## Overview

`darthjee-active_ext` is a small Ruby gem that reopens ActiveRecord classes to add
query helpers. It has no runtime of its own: requiring `darthjee/active_ext` loads
`darthjee/core_ext` (from the `darthjee-core_ext` gem) and the ActiveRecord
extensions, and the new methods are then available on every model and relation.

The logic lives on `ActiveRecord::Relation`. `ActiveRecord::Base` only delegates
the same methods to `all`, so the helpers work both on a model class
(`Document.percentage(...)`) and on any scope chain (`Document.active.percentage(...)`).

## Source Code Layout

All gem source code lives under `lib/`.

### `lib/darthjee.rb` and `lib/darthjee/`

Gem namespace and entry point.

- `darthjee/active_ext.rb`: requires `darthjee/core_ext` and the ActiveRecord
  extensions, and defines the `Darthjee::ActiveExt` module.
- `darthjee/active_ext/version.rb`: `Darthjee::ActiveExt::VERSION`, which the
  gemspec reads.

### `lib/active_record/`

Reopens the ActiveRecord classes.

- `relation_ext.rb`: adds instance methods to `ActiveRecord::Relation`:
  - `percentage(*filters)` (public): the fraction (0.0–1.0) of records in the
    relation that match the filters. Returns `0.0` for an empty relation.
  - `scopped(*filters)` (private API): applies the filters. A list of Symbols is
    chained as named scopes; anything else (a Hash or SQL String) goes to `where`.
    Do not mix the two forms in one call.
  - `pluck_as_json(*keys)` (public): like `pluck`, but returns an array of
    Symbol-keyed hashes (via `Array#as_hash` from `darthjee-core_ext`). With no
    keys it returns `as_json` for each record.
- `base_ext.rb`: delegates `percentage`, `pluck_as_json` and `scopped` from the
  `ActiveRecord::Base` class to `all`. It holds only YARD `@method` docstrings
  that point at the Relation docs.

## Tests

- RSpec, against an in-memory SQLite database (`spec/spec_helper.rb`).
- `spec/support/schema.rb` and `spec/support/models/document.rb` define the
  `Document` test model and its scopes (`with_error`, `with_success`, `active`).
- `spec/support/shared_examples/active_relation.rb` holds shared examples that run
  against both the model class and relations.
- The `lib/` files are listed in `config/check_specs.yml` because their behaviour
  is covered by `spec/lib/active_record/relation_spec.rb`, not by a spec per file.

## Quality Tooling

- YARD docs, with coverage measured by yardstick (`config/yardstick.yml`,
  `rake yardstick_measure`, `rake verify_measurements`).
- RuboCop (`.rubocop.yml`) and RubyCritic (`config/rubycritc.rb`).
- SimpleCov coverage, with an LCOV report on CI (CircleCI and Codacy).
