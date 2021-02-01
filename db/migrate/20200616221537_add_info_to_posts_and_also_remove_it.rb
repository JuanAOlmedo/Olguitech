class AddInfoToPostsAndAlsoRemoveIt < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :title
    remove_column :articles, :text

    add_column :articles, :title, :text
    add_column :articles, :text, :text
  end
end
