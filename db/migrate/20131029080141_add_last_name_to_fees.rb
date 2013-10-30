class AddLastNameToFees < ActiveRecord::Migration
  def change
    add_column :fees, :last_name, :string
  end
end
