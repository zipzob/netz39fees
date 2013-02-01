class AddDefaultValueToFees < ActiveRecord::Migration
  def change
    change_column_default(:fees, :fee, 30.0)
    change_column_default(:fees, :donation, 0.0)
  end
end
