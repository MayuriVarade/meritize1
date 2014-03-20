class CreatePropDisplays < ActiveRecord::Migration
  def change
    create_table :prop_displays do |t|
      t.integer :points
      t.integer :sender_id
      t.integer :receiver_id
      t.text    :description
      t.string :type_cycle

      t.timestamps
    end
  end
end
