# Contributing

## Commit Guidelines

- **Atomic and Unitary:** Each commit must represent a single logical change.
  *Example:*
  - Good: `Add pluck_as_json to ActiveRecord::Relation`
  - Bad: `Add pluck_as_json and refactor scopped logic`
- **No Unrelated Changes:** Do not mix unrelated changes in the same commit.
- **Separate Refactoring:** Whenever possible, separate refactoring commits from new feature or bugfix commits.
- Follow `.github/commit_message_template.md`.

## Pull Requests

- **Descriptive Summary:** Every PR must include a clear and descriptive summary of its purpose and changes (see `.github/pull_request_template.md`).
- **PR Description Files:** If a description cannot be provided directly in the PR, generate a file with the PR description (e.g., `docs/agents/issues/<pr_number>_description.md`), but do not commit this file.

## Definition of Done for PRs

A PR is considered complete when:

- The stated objective has been achieved.
- All specs are passing (`bundle exec rspec`).
- RuboCop passes without offenses (`rubocop`).
- Every public class, module and method has a YARD docstring, and yardstick passes (`bundle exec rake verify_measurements`).
- Code coverage is as high as reasonably possible (SimpleCov).
- Code is not overly complex:
  - Classes and methods should have clear, focused responsibilities.
  - If a class or method is taking on too many responsibilities, refactor to simplify.
  - Methods should be small and do exactly one thing. If a method is growing, extract parts into private helper methods or separate classes.
  - *Example:*

    ```ruby
    # Good: each method does one thing
    class Worker
      def fetch_job; end

      def process_job(job); end
    end

    # Bad: method does too much
    class Worker
      def run
        fetch_job
        process_job
        send_metrics
        cleanup
      end
    end
    ```

  - This requirement applies primarily to source code. For specs, refactor only if there is excessive duplication.

### CI Checks

Before a PR is considered complete, all CI checks must pass locally. This project has a single gem at the root, so both CircleCI jobs apply to any change in `lib/`, `spec/`, `config/` or the root files:

| Modified folder(s) | CircleCI job | Local commands |
| --- | --- | --- |
| `lib/`, `spec/`, `config/`, root files | `test` | `bundle exec rspec` |
| `lib/`, `spec/`, `config/`, root files | `checks` | `rubocop`<br>`bundle exec rake verify_measurements`<br>`check_specs` (all files under `lib/` need a spec or an entry in `config/check_specs.yml`)<br>`rubycritic.sh` and `check_readme.sh` (README must reference the current version; these helpers ship in the CI image `darthjee/circleci_rails_gems`) |

`docker-compose run test_all` runs rspec, yard and the yardstick checks inside the dev container.

Run these same checks when **planning how to resolve an issue**: end the plan with a step that lists the affected folders and the CI commands to run before opening a PR.

## Code Organization

### File Responsibility: Class Declarers vs Scripts

Every source file (excluding specs) must act as a **class declarer**: it defines or reopens one or more classes or modules. Files must not act as **scripts**, meaning they must not run logic or side effects when they are required (beyond `require` statements and class/module definitions).

The only entrypoints are the require files:

| Purpose | Entrypoint |
| --- | --- |
| Gem require (`require 'darthjee/active_ext'`) | `lib/darthjee/active_ext.rb` |
| Namespace require (`require 'darthjee'`) | `lib/darthjee.rb` |

*Example:*

```ruby
# Good: class declarer — reopens a class to add behaviour
module ActiveRecord
  class Relation
    def percentage(*filters); end
  end
end

# Bad: script — executes logic at load time
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
Document.create(status: :error)
```

Specs and `spec/support/` files are exempt from this rule and may run setup code freely.

### File Naming: snake_case Matching the Class

Files must use **snake_case** and match the class or module they define (Zeitwerk-style). Files that extend an existing class end in `_ext`.

*Examples:*

- `lib/darthjee/active_ext.rb` for `Darthjee::ActiveExt`
- `lib/active_record/relation_ext.rb` for extensions to `ActiveRecord::Relation`

Spec files mirror the `lib/` path and end in `_spec.rb`:

- `lib/active_record/relation_ext.rb` → `spec/lib/active_record/relation_spec.rb`

### Method Order: Public Before Private

Within a class, **public methods must be declared before private methods**. Private helpers go at the end of the class body, after a single `private` keyword.

```ruby
# Good: public methods first, private methods last
class Worker
  def run
    prepare
    execute
  end

  def status; end

  private

  def prepare; end

  def execute; end
end

# Bad: private methods mixed in with or before public methods
class Worker
  private def prepare; end

  def run; end

  private def execute; end
end
```

## Dependency Injection

Classes must receive their dependencies (data, configuration, collaborators) as `initialize` arguments. A class must never load files, read `ENV` or fetch configuration on its own.

**Only the entrypoint, or the host application, loads configuration.** It then passes the loaded data to the classes that need it. Extensions to ActiveRecord must work with whatever connection and models the host app provides, and must not open connections or define models themselves.

This makes every class testable on its own: specs instantiate it with the data they need, without touching the filesystem or environment.

```ruby
# Good: receives data as an argument — easy to test
class Router
  def initialize(data)
    @data = data
  end

  def build; end
end

# Bad: loads its own config — couples to the filesystem
class Router
  def build
    data = YAML.load_file('./data.yml') # ❌
  end
end
```

## Refactoring Guidelines

When refactoring, aim to:

- **Reduce Code Duplication:** move repeated spec setup into `let`, `before` blocks, helper methods in `spec/support/`, or shared examples (`spec/support/shared_examples/`).

  ```ruby
  # Good
  shared_examples 'a method that returns the percentage of objects found' do
    # ...
  end

  it_behaves_like 'a method that returns the percentage of objects found'

  # Bad: the same setup and expectations copied into many spec files
  ```
