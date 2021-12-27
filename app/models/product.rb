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

    def self.uncategorized
        self.includes(:categories).where(categories: { id: nil })
    end

    def self.get_ordered(order_by, asc_desc)
        order_by =
            if order_by == 'created_at' || order_by == 'updated_at' ||
                   order_by == 'title' || order_by == 'categories'
                order_by
            else
                'categories'
            end

        order_by =
            order_by == 'title' && I18n.locale == :en ? 'title2' : order_by

        asc_desc = asc_desc == 'asc' || asc_desc == 'desc' ? asc_desc : 'desc'

        if order_by == 'categories'
            categories = Category.all.order(created_at: :desc)
        else
            ordered = self.all.order(order_by => asc_desc)
        end

        return categories, ordered
    end

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
        Rails.application.routes.url_helpers.product_path(id: self.id, locale: I18n.locale)
    end
end
