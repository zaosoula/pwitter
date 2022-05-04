class Post < ApplicationRecord
  belongs_to :user

  has_many :likes
  has_many :liking_users, :through => :likes, :source => :user

  belongs_to :repost, class_name: "Post", optional: true
end
