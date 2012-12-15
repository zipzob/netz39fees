class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.string :name
      t.float :fee
      t.float :donation

      t.timestamps
    end
  end
end
