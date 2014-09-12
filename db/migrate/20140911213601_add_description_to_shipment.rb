class AddDescriptionToShipment < ActiveRecord::Migration
  def change
    add_column :shipments, :description, :string
  end
end
