# Issue Enhancement

A checklist of concerns to consider when fleshing out a vague issue idea (tagged `Idea`/`Writting`) before it reaches the `Created` stage. Not exhaustive — adjust or extend the list for this project's needs.

- **Scope boundaries** — what's explicitly in scope and what's explicitly out.
- **Alternative solutions** — other ways to solve the same problem, and why this one was chosen.
- **Edge cases** — inputs, states, or timing the happy path doesn't cover.
- **Backward compatibility** — whether this breaks existing behavior, data, or integrations.
- **Testing strategy** — how the change will be verified.
- **Performance & security considerations** — anything relevant to load, latency, or attack surface.
- **Rails/ActiveRecord compatibility** — whether the method is chainable, works on both `ActiveRecord::Base` and `ActiveRecord::Relation`, and supports the Ruby/Rails versions declared in the gemspec and Gemfile.
- **Public API & versioning** — whether the gem's public API changes, which semver bump that needs, and which README and YARD examples must be updated.
- **SQL safety & DB portability** — whether user input can reach raw SQL, and whether the query behaves the same across database adapters (SQLite in specs; Postgres/MySQL in host apps).
