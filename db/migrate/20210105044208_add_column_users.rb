class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column    :users, :name,      :string
    change_column :users, :name,      :string,  null: false
    add_column    :users, :image_id,  :string
    add_column    :users, :text,      :string
    change_column :users, :text,      :string,  null: false, default: ""
    add_column    :users, :is_active, :boolean
    change_column :users, :is_active, :boolean, null: false, default: true
  end
end
