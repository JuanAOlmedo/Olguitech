class AddNewsletterSentToArticlesProductsAndProyectos < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :newsletter_sent, :boolean
    add_column :products, :newsletter_sent, :boolean
    add_column :proyectos, :newsletter_sent, :boolean
  end
end
