class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user, index: true
      t.belongs_to :category, index: true
      t.string :title
      t.text :content

      t.timestamps null: false
    end
  end
end
