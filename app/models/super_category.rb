# frozen_string_literal: true

class SuperCategory < ApplicationRecord
    has_many :categories, dependent: :nullify
    has_many :dashboard_categories, lambda {
                                        select(:id, :super_category_id, :title, :slug)
                                    }, class_name: 'Category'

    def localized_title
        return title2 if I18n.locale == :en && !title2.nil? && !title2.empty?

        title
    end

    # Obtener todas las super categorías que tienen categorías relacionadas a algún
    # artículo publicado de tipo name
    def self.related_to(name)
        includes(categories: [name]) # Include categories and the provided model
            .where(categories: { name => { status: 0 } }) # Only allow published solutions
            .distinct # Remove duplicates
    end

    # Obtener tdas las super categorías, con sus categorías y sus respectivos artículos
    # para dashboard
    def self.includes_dashboard_categories
        includes(
            dashboard_categories: {
                dashboard_solutions: { image_attachment: :blob },
                dashboard_products: { image_attachment: :blob },
                dashboard_projects: { image_attachment: :blob }
            }
        )
    end

    # Obtener todas las categorías de una super categoría relacionadas a algún
    # artículo publicado de tipo name
    def categories_related_to(name)
        categories
            .where(name => { status: 0 })
            .includes(name => { image_attachment: :blob })
            .distinct
    end
end
