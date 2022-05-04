class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  
  has_many :posts, -> { order("created_at DESC") }

  has_many :likes
  has_many :liked_posts, :through => :likes, :source => :post
end
