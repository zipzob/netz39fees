class DeleteNameFromFees < ActiveRecord::Migration
  def change
    remove_column :fees, :name
  end
end
