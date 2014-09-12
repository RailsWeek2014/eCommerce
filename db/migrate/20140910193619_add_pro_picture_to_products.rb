class AddProPictureToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pro_picture, :string
  end
end
