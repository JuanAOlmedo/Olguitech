class AddNewsletterOptionToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :newsletter, :boolean
  end
end
