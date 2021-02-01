class AddDescriptionToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :description, :text
  end
end
