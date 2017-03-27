class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :description
      t.string :title
      t.string :image

      t.timestamps
    end
  end
end
