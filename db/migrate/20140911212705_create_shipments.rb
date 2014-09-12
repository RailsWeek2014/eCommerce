class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string :name
      t.float :cost

      t.timestamps
    end
  end
end
