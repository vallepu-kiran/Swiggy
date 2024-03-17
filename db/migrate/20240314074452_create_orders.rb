class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :restaurant, null: false, foreign_key: true
      t.decimal :total_amount
      t.decimal :platform_fee
      t.string :paid_type
      t.decimal :taxes
      t.decimal :discount
      t.datetime :delivered_at

      t.timestamps
    end
  end
end
