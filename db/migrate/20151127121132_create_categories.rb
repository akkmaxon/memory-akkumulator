class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.belongs_to :user, index: true
      t.string :title

      t.timestamps null: false
    end
  end
end
