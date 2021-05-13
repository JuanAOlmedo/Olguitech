class AddContent2ToArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :content2, :text
  end
end
