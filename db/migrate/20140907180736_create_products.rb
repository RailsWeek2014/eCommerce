class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.string :description
      t.string :image

      t.timestamps
    end
  end
end
