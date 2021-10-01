class Category < ApplicationRecord
    has_many :category_categorizables, dependent: :destroy
    has_many :products,
             through: :category_categorizables,
             source: :categorizable,
             source_type: 'Product'
    has_many :articles,
             through: :category_categorizables,
             source: :categorizable,
             source_type: 'Article'
    has_many :proyectos,
             through: :category_categorizables,
             source: :categorizable,
             source_type: 'Proyecto'

    has_one_attached :image

    def get_title
        if I18n.locale == :en && self.title2 != '' && self.title2 != nil
            self.title2
        else
            self.title
        end
    end

    def get_short_title
        title = self.get_title
        return title.length > 15 ? title[0...15] + '...' : title
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
            if description.length > 100
                description[0...100] + '...'
            else
                description
            end
        )
    end

    def change_related(articles, proyectos, products)
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

        if products != nil
            products.each_with_index do |article, i|
                products[i] = Product.find(article.to_i)
                if !self.products.include? products[i]
                    self.products << products[i]
                end
            end
        else
            products = []
        end

        self.products.each do |article|
            self.products.delete(article) if !products.include? article
        end
    end
end
