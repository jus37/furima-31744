class BuyerAddress < ApplicationRecord
  belongs_to :buyer
  with_options presence: true do
    validates :postnumber
    validates :telephonenumber
    validates :area_town
    validates :area_street
  end

  with_options numericality: { other_than: 0 } do
    validates :area_id
  end

end

