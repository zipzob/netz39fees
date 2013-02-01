class AddIbanAndBicToFees < ActiveRecord::Migration
  def change
    add_column :fees, :iban, :string
    add_column :fees, :bic, :string
  end
end
