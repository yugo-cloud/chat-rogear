class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one_attached :image

  validates :content, presence: true, unless: :was_attached?,length: {maximum: 140}

  def was_attached?
    self.image.attached?
  end
end
