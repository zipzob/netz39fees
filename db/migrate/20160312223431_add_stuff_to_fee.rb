class AddStuffToFee < ActiveRecord::Migration
  def change
    add_column :fees, :mandate_id, :string
    add_column :fees, :mandate_date_of_signature, :date
  end
end
