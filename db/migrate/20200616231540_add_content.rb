class AddContent < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :text

    add_column :articles, :content, :text
  end
end
