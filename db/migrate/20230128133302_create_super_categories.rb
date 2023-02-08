class CreateSuperCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :super_categories do |t|
      t.string :title
      t.string :title2

      t.timestamps
    end
  end
end
