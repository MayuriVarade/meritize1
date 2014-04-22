class CreatePaymentNotifications < ActiveRecord::Migration
  def change
    create_table :payment_notifications do |t|
      t.text :params
      t.integer :plan_id
      t.string :status
      t.string :transasction_id

      t.timestamps
    end
  end
end
