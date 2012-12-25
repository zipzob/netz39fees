class AddActivationToFees < ActiveRecord::Migration
  def change
    add_column :fees, :email, :string
    add_column :fees, :activation_token, :string
    add_column :fees, :activated, :boolean, default: false
  end
end
