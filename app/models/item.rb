class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :salesstatus
  belongs_to :shippingfreestatus
  belongs_to :prefecture
  belongs_to :scheduleddelivery
  
  belongs_to :user
  has_one_attached :image
  
  
  

  with_options presence: true do
    validates :name
    validates :description
    validates :price, format: { with: /\A[0-9]+\z/}, inclusion: {in: 300..9999999}
    validates :category_id
    validates :sales_status_id
    validates :shipping_free_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end
  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :sales_status_id
    validates :shipping_free_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

end
