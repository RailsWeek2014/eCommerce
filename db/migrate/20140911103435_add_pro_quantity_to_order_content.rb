class AddProQuantityToOrderContent < ActiveRecord::Migration
  def change
    add_column :order_contents, :pro_quantity, :integer
  end
end
