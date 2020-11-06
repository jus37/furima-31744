class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :area
  belongs_to :cost
  belongs_to :day
  belongs_to :status

  with_options presence: true do
    validates :name
    validates :content
    validates :price
    validates :image
  end
  with_options numericality: {other_than: 0} do
    validates :category_id
    validates :status_id
    validates :cost_id
    validates :area_id
    validates :days
  end


end
