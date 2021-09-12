class AddNewsletterTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :newsletter_token, :string
  end
end
