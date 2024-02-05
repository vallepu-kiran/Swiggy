class ChangeRatingDataTypeForRestaurants < ActiveRecord::Migration[7.1]
  def change
    change_column(:restaurants, :rating, :float)
  end
end
