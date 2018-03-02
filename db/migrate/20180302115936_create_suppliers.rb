class CreateSuppliers < ActiveRecord::Migration[5.1]
  def change
    create_table :suppliers, primary_key: :supplier_id do |t|
      t.string :supplier_id
      t.string :name

      t.timestamps
    end
    # execute "ALTER TABLE suppliers ADD PRIMARY KEY (supplier_id);"
  end
end
