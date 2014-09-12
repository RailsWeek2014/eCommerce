class AddAttachmentProPicToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :pro_pic
    end
  end

  def self.down
    remove_attachment :users, :pro_pic
  end
end
