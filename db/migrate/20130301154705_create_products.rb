class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :item_number
      t.string :description
      t.string :category
      t.decimal :current_retail_price
      t.decimal :current_cpo
      t.decimal :current_point_value

      t.timestamps
    end
  end
end
