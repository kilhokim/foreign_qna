class CreateVotelogs < ActiveRecord::Migration
  def change
    create_table :votelogs do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :isVoted

      t.timestamps
    end
  end
end
