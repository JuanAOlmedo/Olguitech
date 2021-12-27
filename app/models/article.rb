class Article < ApplicationRecord
    include Getters

    has_rich_text :content
    has_rich_text :content2
    has_one_attached :image

    has_many :product_referenceables, as: :referenceable, dependent: :destroy
    has_many :products, through: :product_referenceables, as: :referenceable

    has_many :category_categorizables, as: :categorizable, dependent: :destroy
    has_many :categories, through: :category_categorizables, as: :categorizable

    def change_categories_and_products(categories, products)
        if products != nil
            products.each_with_index do |product, i|
                products[i] = Product.find(product.to_i)
                if !self.products.include? products[i]
                    products[i].articles << self
                end
            end
        else
            products = []
        end

        self.products.each do |product|
            self.products.delete(product) if !products.include? product
        end

        if categories != nil
            categories.each_with_index do |category, i|
                categories[i] = Category.find(category.to_i)
                if !self.categories.include? categories[i]
                    categories[i].articles << self
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
        Rails.application.routes.url_helpers.article_path(id: self.id, locale: I18n.locale)
    end
end
