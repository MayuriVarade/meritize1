class AddAttachmentPhotoToSettings < ActiveRecord::Migration
  def self.up
    change_table :settings do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :settings, :photo
  end
end
