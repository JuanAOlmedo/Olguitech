class CreateNewsletters < ActiveRecord::Migration[6.0]
  def change
    create_table :newsletters do |t|
      t.text :title
      t.text :content
      t.text :subject

      t.timestamps
    end
  end
end
