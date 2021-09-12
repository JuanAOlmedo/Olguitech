class Product < ApplicationRecord
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

    def get_title
        if I18n.locale == :en && self.title2 != '' && self.title2 != nil
            self.title2
        else
            self.title
        end
    end

    def get_short_title
        title = self.get_title
        return title.length > 35 ? title[0...35] + '...' : title
    end

    def get_desc
        if I18n.locale == :en && self.description2 != '' &&
               self.description2 != nil
            self.description2
        else
            self.description
        end
    end

    def get_short_desc
        description = self.get_desc
        return(
            description.length > 90 ? description[0...90] + '...' : description
        )
    end

    def get_content
        if I18n.locale == :en && !self.content2.empty?
            self.content2
        else
            self.content
        end
    end

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
            if !articles.include? article
                self
                    .product_referenceables
                    .find_by(referenceable_id: article.id)
                    .destroy
            end
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
            if !proyectos.include? article
                self
                    .product_referenceables
                    .find_by(referenceable_id: article.id)
                    .destroy
            end
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
            if !categories.include? category
                self
                    .category_categorizables
                    .find_by(category_id: category.id)
                    .destroy
            end
        end
    end
end
