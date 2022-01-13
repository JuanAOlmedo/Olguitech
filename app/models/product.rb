class Product < ApplicationRecord
    include Getters

    extend FriendlyId
    friendly_id :title, use: :slugged
    
    has_rich_text :content
    has_rich_text :content2

    has_many :product_referenceables, dependent: :destroy
    has_many :articles,
             through: :product_referenceables,
             source: :referenceable,
             source_type: 'Article'
    has_many :proyectos,
             through: :product_referenceables,
             source: :referenceable,
             source_type: 'Proyecto'

    has_one_attached :image

    has_many :category_categorizables, as: :categorizable, dependent: :destroy
    has_many :categories, through: :category_categorizables, as: :categorizable

    def change_related(articles, proyectos, categories)
        if articles != nil
            articles.each_with_index do |article, i|
                articles[i] = Article.find(article.to_i)
                if !self.articles.include? articles[i]
                    self.articles << articles[i]
                end
            end
        else
            articles = []
        end

        self.articles.each do |article|
            self.articles.delete(article) if !articles.include? article
        end

        if proyectos != nil
            proyectos.each_with_index do |article, i|
                proyectos[i] = Proyecto.find(article.to_i)
                if !self.proyectos.include? proyectos[i]
                    self.proyectos << proyectos[i]
                end
            end
        else
            proyectos = []
        end

        self.proyectos.each do |article|
            self.proyectos.delete(article) if !proyectos.include? article
        end

        if categories != nil
            categories.each_with_index do |category, i|
                categories[i] = Category.find(category.to_i)
                if !self.categories.include? categories[i]
                    categories[i].products << self
                end
            end
        else
            categories = []
        end

        self.categories.each do |category|
            self.categories.delete(category) if !categories.include? category
        end
    end

    def base_uri
        Rails.application.routes.url_helpers.product_path(self, locale: I18n.locale)
    end
end
