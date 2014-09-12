class Product < ActiveRecord::Base
	validates :name, presence: true
	validates :description, presence: true
	validates :cid, presence: true


 mount_uploader :pro_picture, ProPictureUploader
end
