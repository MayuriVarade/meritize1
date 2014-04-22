class CreateNominees < ActiveRecord::Migration
  def change
    create_table :nominees do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end
