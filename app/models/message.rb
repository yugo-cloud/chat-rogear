class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one_attached :image #imageメソッドが使えるようになっている
  has_one_attached :file  #fileメソッドが使えるようになっている

  validates :content, presence: true, unless: :was_attached?,length: {maximum: 140}

  def was_attached?
    self.image.attached?
    self.file.attached?
  end
end
