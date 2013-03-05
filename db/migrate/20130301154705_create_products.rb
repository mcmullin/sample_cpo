class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :item
      t.string :description
      t.float :retail
      t.float :cpo
      t.float :points
      t.string :category

      t.timestamps
    end
  end
end
