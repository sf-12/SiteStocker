class CreateTweetSites < ActiveRecord::Migration[5.2]
  def change
    create_table :tweet_sites do |t|
      t.integer :tweet_id,  null: false
      t.integer :site_id,   null: false
      t.timestamps
    end
  end
end
