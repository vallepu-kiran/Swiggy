class CreateRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :special
      t.integer :rating 
      t.string :address


      t.timestamps
    end
  end
end
