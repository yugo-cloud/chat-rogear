class Message < ApplicationRecord
  belongs_to :user        #この記述でuserを定義することでuserメソッド(.user)が使えるようになっている
  belongs_to :room        #この記述でroomを定義することでroomメソッド(.room)が使えるようになっている
  has_one_attached :image #この記述でimageを定義することでimageメソッド(.image)が使えるようになっている
  has_one_attached :file  #この記述でfileを定義することでfileメソッド(.file)が使えるようになっている

  validates :content, presence: true, length: {maximum: 140}, unless: :was_attached? 

  def was_attached?
    self.image.attached? || self.file.attached?   
  end
end

#7行目…unlessオプションにメソッド名を指定： 「メソッドの返り値がfalseならばバリデーションによる検証を行う」という意味
#7行目あと、 validates に if や unless で条件を付ける時は末尾に付けた方が分かりやすいです。
#「このバリデーションを条件の時に行う（行わない）」という意味なので上記のように末尾に付けた方が読みやすいです。

#attached?メソッド  レコードにファイルが添付されているかどうかで、trueかfalseを返すメソッド。 
#attached = 添付 
