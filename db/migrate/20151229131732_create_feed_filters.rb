class CreateFeedFilters < ActiveRecord::Migration
  def change
    create_table :feed_filters do |t|
      t.integer :user_id, index: true
      t.integer :hidden_category_id, index: true

      t.timestamps null: false
    end
    add_index :feed_filters, [:user_id, :hidden_category_id], unique: true
  end
end
