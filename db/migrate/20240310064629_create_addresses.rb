class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :location
      t.string :landmark
      t.string :door_number
      t.string :address_type
      t.string :other_address_type

      t.timestamps
    end
  end
end
