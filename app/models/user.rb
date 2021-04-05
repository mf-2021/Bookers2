class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # UseモデルはRelationshipクラスにfollowerを"follower_id"keyで持ってます
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # そして、followerを通して、followed_usersを持っています。ちなみにその際のkeyとなるカラムはfollowedです。（throughとsourceは"_id"が隠れている）
  has_many :followed_users, through: :follower, source: :followed
  #上記２コードの裏返し
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :follower_users, through: :followed, source: :follower


  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: {in: 2..20}
  validates :introduction, length: {maximum: 50}

end
