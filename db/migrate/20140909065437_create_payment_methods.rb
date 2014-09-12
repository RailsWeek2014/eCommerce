class CreatePaymentMethods < ActiveRecord::Migration
  def change
    create_table :payment_methods do |t|
      t.string :payment_name
      t.string :payment_description

      t.timestamps
    end
  end
end
