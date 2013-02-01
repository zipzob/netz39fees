class AddBankAccountOwnerToFees < ActiveRecord::Migration
  def change
    add_column :fees, :bank_account_owner, :string
  end
end
