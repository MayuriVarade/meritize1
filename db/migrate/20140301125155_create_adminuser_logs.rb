class CreateAdminuserLogs < ActiveRecord::Migration
  def change
    create_table :adminuser_logs do |t|
      t.integer  :user_id
      t.integer  :admin_user_id
      t.datetime  :sign_in_time
      t.datetime  :sign_out_time
      t.string    :ip_address
      t.string    :firstname
      t.string    :lastname
      t.string    :username
      t.string    :fullname
      t.string    :email
      t.string    :sign_in_count
      t.timestamps
    end
  end
end
