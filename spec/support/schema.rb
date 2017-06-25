ActiveRecord::Schema.define do
  self.verbose = false

  create_table :documents, :force => true do |t|
    t.string :status
    t.boolean :active, default: false
    t.timestamps null: true
  end
end
