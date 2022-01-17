class ChangeDefaultViewsToModelsAndMakeNewsletterTokenAnIndexOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :articles, :views, from: nil, to: 0
    change_column_default :proyectos, :views, from: nil, to: 0
    change_column_default :products, :views, from: nil, to: 0

    add_index :users, :newsletter_token, unique: true
  end
end
