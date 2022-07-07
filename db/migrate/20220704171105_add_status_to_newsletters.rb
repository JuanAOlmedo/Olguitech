class AddStatusToNewsletters < ActiveRecord::Migration[7.0]
  def change
    add_column :newsletters, :status, :integer
  end
end
