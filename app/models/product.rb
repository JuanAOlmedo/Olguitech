class Product < ApplicationRecord
    has_many :product_referenceables, dependent: :destroy
    has_many :articles, through: :product_referenceables, source: :referenceable, source_type: "Article"
    has_many :proyectos, through: :product_referenceables, source: :referenceable, source_type: "Proyecto"
    
    has_one_attached :image

    has_many :category_categorizables, as: :categorizable, dependent: :destroy
    has_many :categories, through: :category_categorizables, as: :categorizable

    def get_title
        I18n.locale == :en && self.title2 != "" && self.title2 != nil ? self.title2 : self.title
    end

    def get_short_title
        title = self.get_title
        return title.length > 35 ? title[0...35] + '...' : title
    end

    def get_desc
        I18n.locale == :en && self.description2 != "" && self.description2 != nil ? self.description2 : self.description
    end

    def get_short_desc
        description = self.get_desc
        return description.length > 90 ? description[0...90] + '...' : description
    end
end