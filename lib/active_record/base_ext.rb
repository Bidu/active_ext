require 'active_record'

module ActiveRecord
  class Base
    class << self
      delegate :percentage, :pluck_as_json, to: :all
    end
  end
end

