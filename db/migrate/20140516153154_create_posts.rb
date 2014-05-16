class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :facebook_id
      t.string :facebook_link
      t.string :learn
      t.string :teach
      t.string :where

      t.timestamps
    end
  end
end
