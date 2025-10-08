class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :price_cents
      t.integer :stock
      t.string :slug

      t.timestamps
    end
  end
end
