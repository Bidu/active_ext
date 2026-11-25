# GitHub Copilot Instructions for `darthjee/active_ext`

## Project Overview

`active_ext` is a Ruby gem that provides extension methods to be used with
**ActiveRecord** and **ActiveSupport** (Ruby on Rails components). It enriches
`ActiveRecord::Relation` and related classes with additional query helpers and
utilities, keeping the extensions idiomatic, lightweight, and Rails-friendly.

---

## Language

All contributions must be in **English**:

- Pull request titles and descriptions
- Code comments and inline documentation
- YARD docstrings and examples
- Commit messages
- Identifiers (class names, method names, variable names, etc.)

---

## Testing

- **Always add tests** for every change, bug fix, or new feature.
- Tests live under `spec/` and use **RSpec**.
- Follow the existing spec structure: place specs next to the corresponding
  `lib/` file (e.g., `lib/active_record/my_extension.rb` →
  `spec/lib/active_record/my_extension_spec.rb`).
- If a source file genuinely cannot have a spec (e.g., it only re-exports
  constants or requires other files), list it in **`check_specs.yml`** so it
  is explicitly acknowledged as exempt from the coverage requirement.

---

## Code Documentation (YARD)

- Provide documentation compatible with **YARD**.
- Every **public** class, module, and method must include a YARD docstring.
- Include `@param`, `@return`, and `@example` tags where appropriate.
- Example:

```ruby
# Returns the percentage of records matching +scope+ within the current
# relation.
#
# @param scope [Symbol, Hash, String] the scope or condition to evaluate
# @return [Float] percentage as a decimal between 0.0 and 1.0
#
# @example Using a named scope
#   Document.percentage(:with_error) #=> 0.75
#
# @example Using a hash condition
#   Document.percentage(status: :error) #=> 0.75
#
# @example Within a nested scope
#   Document.active.percentage(:with_error) #=> 0.5
def percentage(scope)
  # ...
end
```

---

## Design & Quality

Follow the principles championed by **Sandi Metz** (as described in
*99 Bottles of OOP* and *Practical Object-Oriented Design*):

- **Small classes and methods** — each should have a single, well-defined
  responsibility.
- **Limit method length** — prefer short, readable methods over long ones.
- **Prefer composition over inheritance** when extending behavior.
- **Avoid Law of Demeter violations** — an object should only talk to its
  immediate collaborators; avoid long method-chain calls like
  `a.b.c.do_something`.
- **Favor clear, explicit boundaries** — modules and classes should expose
  minimal public APIs and hide implementation details.

---

## Rails & ActiveRecord Compatibility

- Extensions must remain **Rails-friendly**: follow Rails conventions and
  naming patterns.
- New methods added to `ActiveRecord::Relation` or `ActiveSupport` classes
  should integrate naturally with existing Rails query interfaces (scopes,
  chainability, etc.).
- Avoid monkey-patching core Ruby classes unless absolutely necessary; prefer
  extending the appropriate Rails base classes or using `ActiveSupport::Concern`.
- Ensure compatibility with the Ruby and Rails versions declared in
  `active_ext.gemspec` and `Gemfile`.

---

## Pull Request Guidelines

- Keep PRs focused and small — one logical change per PR.
- Include a clear description of *what* changed and *why*.
- Reference any related issues.
- Ensure all existing and new specs pass before requesting review.

## Documentation

All project documentation lives under [`docs/agents/`](docs/agents/):

| File | Contents |
|------|----------|
| [Folder Structure](docs/agents/folder-structure.md) | Top-level directory layout and the role of each folder. |
| [Architecture](docs/agents/architecture.md) | Source layout, modules, code style, and implementation guidelines. |
| [Flow](docs/agents/flow.md) | Main runtime flow of the application. |
| [Contributing](docs/agents/contributing.md) | Commit guidelines, PR standards, code organization, and refactoring rules. |
| [Plans](docs/agents/plans/) | Implementation plans for ongoing or upcoming features. |
| [Issues](docs/agents/issues/) | Detailed specs for open issues. |

### Issues (`docs/agents/issues/`)

Each file documents an issue in detail. Naming convention:

```
docs/agents/issues/<issue_id>_<issue_name>.md
```

Example: `docs/agents/issues/5_release_docker_image.md` for issue #5.

### Plans (`docs/agents/plans/`)

Each plan is a directory named after the issue ID and topic, containing one or more related files:

```
docs/agents/plans/<issue_id>_<topic>/<related_files>.md
```

Example: `docs/agents/plans/12_add-auth/plan.md` for issue #12.

## Commit Attribution

Commit co-author trailers follow arcanum's resolved `git.omit_model_coauthor` and `git.remove_coauthors` config (check them with `/arcanum-check-config`); this overrides Claude Code's own attribution reminder for every commit, including ones written by hand.
