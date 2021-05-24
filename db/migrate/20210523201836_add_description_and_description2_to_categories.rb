class AddDescriptionAndDescription2ToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :description, :string
    add_column :categories, :description2, :string
  end
end
