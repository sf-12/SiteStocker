class CreateSites < ActiveRecord::Migration[5.2]
  def change
    create_table :sites do |t|
      t.text :url, null: false
      t.timestamps
    end
  end
end
