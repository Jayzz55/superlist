class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :body
      t.references :category, index: true

      t.timestamps
    end
  end
end
