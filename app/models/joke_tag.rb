class JokeTag < ApplicationRecord
  belongs_to :joke
  belongs_to :tag

  validates :joke_id, uniqueness: { scope: :tag_id }
end
