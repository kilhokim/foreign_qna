class CreateVotecommentlogs < ActiveRecord::Migration
  def change
    create_table :votecommentlogs do |t|
      t.integer :user_id
      t.integer :comment_id
      t.integer :vote_score

      t.timestamps
    end
  end
end
