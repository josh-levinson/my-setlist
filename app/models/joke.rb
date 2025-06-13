class Joke < ApplicationRecord
  belongs_to :user
  has_many :joke_tags, dependent: :destroy
  has_many :tags, through: :joke_tags
end
