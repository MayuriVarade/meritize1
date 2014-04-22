class AddVoteSettingIdToNominee < ActiveRecord::Migration
  def change
    add_column :nominees, :vote_setting_id, :integer
  end
end
