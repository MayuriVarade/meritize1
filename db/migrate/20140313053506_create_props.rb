class CreateProps < ActiveRecord::Migration
  def change
    create_table :props do |t|
      t.boolean :enable
      t.boolean :assign_points
      t.integer :start_point
      t.integer :end_point
      t.integer :step_point
      t.string :reset_point
      t.integer :user_id
      t.date :start_cycle
      t.date :end_cycle
      t.string :name
      t.string :email
      t.string :subject
      t.text :body
      t.string :subject2
      t.text :body2
      t.string :subject3
      t.text :body3
      t.text :intro

      t.timestamps
    end
  end
end
