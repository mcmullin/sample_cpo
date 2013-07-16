class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :number
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end
