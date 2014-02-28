class CreatePaypalPayments < ActiveRecord::Migration
  def change
    create_table :paypal_payments do |t|

      t.timestamps
    end
  end
end
