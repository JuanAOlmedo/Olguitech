class AddTranslatedColumnsToArticlesAndProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :proyectos, :content2, :text

    add_column :articles, :title2, :text
    add_column :proyectos, :title2, :text

    add_column :articles, :description2, :text
    add_column :proyectos, :description2, :text
  end
end
