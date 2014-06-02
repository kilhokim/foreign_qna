class CreateCounts < ActiveRecord::Migration
  def change
    create_table :counts do |t|
      t.integer :shortcut_no

      t.timestamps
    end
  end
end
