class Category < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

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

    def base_uri
        Rails.application.routes.url_helpers.category_path(self, locale: I18n.locale)
    end
end
