class CreateJokes < ActiveRecord::Migration[8.0]
  def change
    create_table :jokes do |t|

      t.string :name, null: false
      t.string :description
      t.text :content
      t.decimal :rating

      t.timestamps
    end
  end
end
