class CreateBillionaires < ActiveRecord::Migration[7.0]
  def change
    create_table :billionaires do |t|
      t.string :name, null: false
      t.string :title, null: false
      t.text :image, null: false
      t.float :price, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
