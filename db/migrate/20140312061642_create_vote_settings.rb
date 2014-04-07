class CreateVoteSettings < ActiveRecord::Migration
  def change
    create_table :vote_settings do |t|
      t.string :award_program_name
      t.string :award_frequency_type
      t.date :start_cycle
      t.date :end_cycle
      t.text :intro_text

      t.timestamps
    end
  end
end
