class User < ApplicationRecord
  has_secure_password

  has_many :ideas, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_ideas, through: :likes, source: :idea

  validates :name, :email, presence: true
  validates :password, presence: true, :on => :create
end
