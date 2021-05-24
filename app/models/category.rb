class Category < ApplicationRecord
    has_many :category_categorizables, dependent: :destroy
    has_many :products, through: :category_categorizables, source: :categorizable, source_type: "Product"
    has_many :articles, through: :category_categorizables, source: :categorizable, source_type: "Article"
    has_many :proyectos, through: :category_categorizables, source: :categorizable, source_type: "Proyecto"

    has_one_attached :image

    def get_title
        I18n.locale == :en && self.title2 != "" && self.title2 != nil ? self.title2 : self.title
    end

    def get_short_title
        title = self.get_title
        return title.length > 10 ? title[0...10] + '...' : title
    end

    def get_desc
        I18n.locale == :en && self.description2 != "" && self.description2 != nil ? self.description2 : self.description
    end

    def get_short_desc
        description = self.get_desc
        return description.length > 100 ? description[0...100] + '...' : description
    end
end
