ActiveExt
==========

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/darthjee/active_ext/tree/main.svg?style=svg)](https://dl.circleci.com/status-badge/redirect/gh/darthjee/active_ext/tree/main)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/ba204b06239b4e1483fe1ce2fb4aced2)](https://app.codacy.com/gh/darthjee/active_ext/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
[![Codacy Badge](https://app.codacy.com/project/badge/Coverage/ba204b06239b4e1483fe1ce2fb4aced2)](https://app.codacy.com/gh/darthjee/active_ext/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_coverage)
[![Gem Version](https://badge.fury.io/rb/darthjee-active_ext.svg)](https://badge.fury.io/rb/darthjee-active_ext)

![active_ext](https://raw.githubusercontent.com/darthjee/active_ext/main/active_ext.jpg)

**Current Release**: [2.0.0](https://github.com/darthjee/active_ext/tree/2.0.0)

**Next release**: [2.1.0](https://github.com/darthjee/active_ext/compare/2.0.0...main)

Yard Documentation
-------------------
[https://www.rubydoc.info/gems/darthjee-active_ext/2.0.0](https://www.rubydoc.info/gems/darthjee-active_ext/2.0.0)


# Usage
This project adds some new methods to the core active_record classes

To use active-ext either intall directly

```console
gem install darthjee-active_ext
```

or add it to Gemfile

```
gem 'darthjee-active_ext'
```

```console
bundle install darthjee-active_ext
```

# methods added

## ActiveRecord::Relation

```ruby
ActiveRecord::Schema.define do
  self.verbose = false
  
  create_table :documents, :force => true do |t|
    t.string :status
    t.boolean :active, default: false
    t.timestamps null: true
  end
end


class Document < ActiveRecord::Base
  scope :with_error, -> { where(status: :error) }
  scope :with_success, -> { where(status: :success) }
  scope :active, -> { where(active: true) }
end

2.times { Document.with_error.create }
Document.active.with_error.create
Document.active.with_success.create
```

### #percentage
Returns the percentage of objects of a certain scope within another scope

```ruby
Document.percentage(:with_error)
0.75
```

```ruby
Document.percentage(status: :error)
0.75
```

```ruby
Document.percentage("status = 'error'")
0.75
```
Works also when using nested scopes

```ruby
Document.active.percentage(:with_error)
0.5
```

### #pluck_as_json
Just as pluck returns some specifc columns, pluck_as_json returns the same coluns with keys to identify

```ruby
Document.pluck(:id, :active)
[[1, true], [2, true]]
```

```ruby
Document.pluck_as_json(:id, :active)
[
  {id: 18, active: false},
  {id: 19, active: false},
  {id: 20, active: true},
  {id: 21, active: true}
]
```
