# frozen_string_literal: true

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
        return title2 if I18n.locale == :en && !title2.empty? && !title2.nil?

        title
    end

    def get_short_title
        title = get_title
        return if title.nil?

        title.length > 15 ? "#{title[0...15]}..." : title
    end

    def get_desc
        return description2 if I18n.locale == :en && !description2.empty? && !description2.nil?

        description
    end

    def get_short_desc
        description = get_desc
        return if description.nil?

        description.length > 100 ? "#{description[0...100]}..." : description
    end

    def self.related_to(model)
        Category.includes(model).where.not(model => { id: nil })
    end

    def base_uri
        Rails.application.routes.url_helpers.category_path(self, locale: I18n.locale)
    end
end
