class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :payment_id
      t.float :amount
      t.integer :shipment_id

      t.timestamps
    end
  end
end
