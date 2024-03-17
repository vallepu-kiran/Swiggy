class ChangeAddressType < ActiveRecord::Migration[7.1]
  def up
    change_column(:addresses, :address_type, :integer, limit: 1)
  end

  def down
    change_column(:addresses, :address_type, :string)
  end
end
