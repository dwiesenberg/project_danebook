class ChangeLikableinLikes < ActiveRecord::Migration
  def up
    rename_column :likes, :likeable_id, :likable_id
    rename_column :likes, :likeable_type, :likable_type
  end

  def down
  	rename_column :likes, :likeable_id, :likable_id
  	rename_column :likes, :likeable_type, :likable_type
  end
end
