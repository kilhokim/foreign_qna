class CreateVotelogs < ActiveRecord::Migration
  def change
    create_table :votelogs do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :vote_score

      t.timestamps
    end
  end
end
