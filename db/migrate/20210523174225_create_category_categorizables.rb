class CreateCategoryCategorizables < ActiveRecord::Migration[6.1]
  def change
    create_table :category_categorizables do |t|
        t.integer :category_id
        t.integer :categorizable_id
        t.string :categorizable_type

        t.timestamps
    end
  end
end
