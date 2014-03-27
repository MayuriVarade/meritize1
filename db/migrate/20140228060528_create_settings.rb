class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :company_name
      t.string :website_address
      t.text :description

      t.timestamps
    end
  end
end
