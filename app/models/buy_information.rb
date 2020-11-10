class BuyInformation
  include ActiveModel::Model
  attr_accessor :postnumber, :telephonenumber, :area_id, :area_town, :area_street, :building_name, :item_id, :user_id, :token
  
  with_options presence: true do
    validates :area_town
    validates :area_street
    validates :token
  end

  with_options presence: true,format: { with: /\A\d{3}[-]\d{4}\z/} do
    validates :postnumber
  end
  
  with_options presence: true, format: { with: /\A[0-9]+\z/}, length: {maximum: 8} do
    validates :telephonenumber
  end


  with_options numericality: { other_than: 0 } do
    validates :area_id
  end
  
  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    BuyerAddress.create(postnumber: postnumber, telephonenumber: telephonenumber, area_id: area_id, area_town: area_town, area_street: area_street, building_name: building_name, buyer_id: buyer.id)
  end
end