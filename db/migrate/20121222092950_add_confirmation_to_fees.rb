class AddActivationToFees < ActiveRecord::Migration
  def change
    add_column :fees, :email, :string
    add_column :fees, :confirmation_token, :string
    add_column :fees, :confirmed, :boolean, default: false
  end
end
