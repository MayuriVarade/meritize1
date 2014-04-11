class AddCountToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :count, :integer,:default => 0 , :null => false
  end
end
