class Proyecto < ApplicationRecord
    has_rich_text :content
    has_rich_text :content2
    has_one_attached :image

    has_many :product_referenceables, foreign_key: :referenceable_id
    has_many :products, through: :product_referenceables, as: :referenceable

    def get_title
        I18n.locale == :en && self.title2 != "" && self.title2 != nil ? self.title2 : self.title
    end

    def get_short_title
        title = self.get_title
        return title.length > 50 ? title[0...50] + '...' : title
    end

    def get_desc
        I18n.locale == :en && self.description2 != "" && self.description2 != nil ? self.description2 : self.description
    end

    def get_short_desc
        description = self.get_desc
        return description.length > 100 ? description[0...100] + '...' : description
    end

    def get_content
        I18n.locale == :en && !self.content2.empty? ? self.content2 : self.content
    end
end
