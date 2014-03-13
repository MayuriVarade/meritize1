class CreateCoreValues < ActiveRecord::Migration
  def change
    create_table :core_values do |t|
      t.string :title
      t.text   :description
      t.integer :setting_id
      t.timestamps
    end
  end
end
