class AddSlugToNewsletters < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletters, :slug, :string
    add_index :newsletters, :slug, unique: true
  end
end
