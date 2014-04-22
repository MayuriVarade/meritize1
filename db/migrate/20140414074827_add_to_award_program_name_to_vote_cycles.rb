class AddToAwardProgramNameToVoteCycles < ActiveRecord::Migration
  def change
    add_column :vote_cycles, :award_program_name, :string
  end
end
