class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :body

      t.timestamps
    end
  end
end
