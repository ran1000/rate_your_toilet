class Review < ApplicationRecord
  belongs_to :toilet
  belongs_to :user
end
