class AddDepartmentToAdminuserLog < ActiveRecord::Migration
  def change
    add_column :adminuser_logs, :department, :string
  end
end
