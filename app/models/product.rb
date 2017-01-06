class Product < ApplicationRecord
  belongs_to :category

  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :suggests, dependent: :destroy
  has_many :product_vieweds, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  mount_uploader :up_picture, PictureUploader

  validates :category_id, presence: true
  validates :price, presence: true, numericality: {only_integer: true}  

  scope :search_product, ->search do   
    where("name LIKE ?","%#{search}%").order "price" if search.present?
  end
end
