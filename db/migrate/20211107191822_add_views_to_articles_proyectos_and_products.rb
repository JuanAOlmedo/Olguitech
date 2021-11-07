class AddViewsToArticlesProyectosAndProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :views, :integer
    add_column :proyectos, :views, :integer
    add_column :products, :views, :integer
  end
end
