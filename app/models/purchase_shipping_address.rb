class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id,
                :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ }
    validates :city
    validates :addresses
    validates :phone_number, numericality: { only_integer: true }, length: { in: 1..11 }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "can' be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses,
                           building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end
