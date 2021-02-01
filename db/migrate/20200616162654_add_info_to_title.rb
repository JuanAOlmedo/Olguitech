class AddInfoToTitle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :title, :string
    add_column :articles, :text, :string
  end
end
