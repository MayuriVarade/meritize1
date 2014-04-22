class AddEmailTemplateToVoteSettings < ActiveRecord::Migration
  def change
  	add_column :vote_settings, :email_sender_name, :string
  	add_column :vote_settings, :email_sender_email, :string
  	add_column :vote_settings, :email_sender_subject1, :string
  	add_column :vote_settings, :email_sender_body1, :text
  	add_column :vote_settings, :email_sender_subject2, :string
  	add_column :vote_settings, :email_sender_body2, :text
  	add_column :vote_settings, :email_sender_subject3, :string
  	add_column :vote_settings, :email_sender_body3, :text
  end
end
