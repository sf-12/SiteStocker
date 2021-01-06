class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.integer :user_id,   null: false
      t.integer :site_id,   null: false
      t.string  :text,      null: false
      t.boolean :is_opened, null: false, default: true
      t.timestamps
    end
  end
end
