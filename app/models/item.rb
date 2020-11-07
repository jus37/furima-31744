class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :area
  belongs_to :cost
  belongs_to :send_day
  belongs_to :status

  with_options presence: true do
    validates :name
    validates :content
    validates :image
  end
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }, format: { with: /\A[0-9]+\z/, message: '半角で入力してください' }

  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :status_id
    validates :cost_id
    validates :area_id
    validates :send_day_id
  end
end
