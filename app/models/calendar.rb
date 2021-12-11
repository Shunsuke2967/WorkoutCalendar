class Calendar < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :title, length: { maximum: 10 }
  validates :memo, length: { maximum: 150 }
end
