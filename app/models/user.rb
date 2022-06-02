class User < ApplicationRecord
  # has_many :toilets     --> if we want to display created toilets later we need to work with aliases
  has_many :favorites
  has_many :toilets_as_favorites, through: :favorites, source: :toilets
  has_many :toilets
  has_many :reviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
