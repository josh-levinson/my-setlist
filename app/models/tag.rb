class Tag < ApplicationRecord
  belongs_to :user
  has_many :joke_tags, dependent: :destroy
  has_many :jokes, through: :joke_tags

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :color, presence: true
end
