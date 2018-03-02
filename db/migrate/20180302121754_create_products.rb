class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products, primary_key: :sku do |t|
      t.integer :sku
      t.string :field1
      t.string :field2
      t.string :field3
      t.string :field4
      t.string :field5
      t.string :field6
      t.float :price

      t.timestamps
    end
    # execute "ALTER TABLE products ADD PRIMARY KEY (sku);"
  end
end
