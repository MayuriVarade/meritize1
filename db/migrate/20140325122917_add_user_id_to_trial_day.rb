class AddUserIdToTrialDay < ActiveRecord::Migration
  def change
    add_column :trial_days, :user_id, :integer
  end
end
