class AddUserIdToJokes < ActiveRecord::Migration[8.0]
  def change
    add_reference :jokes, :user, null: true, foreign_key: true
    # Set all existing jokes to the first user (if any exists)
    if User.exists?
      Joke.update_all(user_id: User.first.id)
    end
    # Now make the column required
    change_column_null :jokes, :user_id, false
  end
end
