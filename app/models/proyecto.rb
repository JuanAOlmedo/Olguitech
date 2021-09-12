class Proyecto < ApplicationRecord
    has_rich_text :content
    has_rich_text :content2
    has_one_attached :image

    has_many :product_referenceables, as: :referenceable, dependent: :destroy
    has_many :products, through: :product_referenceables, as: :referenceable

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
            if !products.include? product
                self
                    .product_referenceables
                    .find_by(product_id: product.id)
                    .destroy
            end
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
            if !categories.include? category
                self
                    .category_categorizables
                    .find_by(category_id: category.id)
                    .destroy
            end
        end
    end
end
