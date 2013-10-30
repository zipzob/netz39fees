class AddFirstNameToFees < ActiveRecord::Migration
  def change
    add_column :fees, :first_name, :string
  end
end
