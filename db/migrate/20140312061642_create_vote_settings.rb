class CreateVoteSettings < ActiveRecord::Migration
  def change
    create_table :vote_settings do |t|
      t.string :award_program_name
      t.string :award_frequency_type
      t.datetime :start_cycle
      t.datetime :end_cycle
      t.text :intro_text

      t.timestamps
    end
  end
end
