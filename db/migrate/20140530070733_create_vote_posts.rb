class CreateVotePosts < ActiveRecord::Migration
  def change
    create_table :vote_posts do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :isVoted

      t.timestamps
    end
  end
end
