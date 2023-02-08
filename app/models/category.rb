# frozen_string_literal: true

class Category < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    belongs_to :super_category, optional: true
    has_many :category_categorizables, dependent: :destroy
    has_many :products,
             through: :category_categorizables,
             source: :categorizable,
             source_type: 'Product'
    has_many :articles,
             through: :category_categorizables,
             source: :categorizable,
             source_type: 'Article'
    has_many :projects,
             through: :category_categorizables,
             source: :categorizable,
             source_type: 'Project'

    has_many :dashboard_products,
             -> { select(:id, :title, :status, :slug) },
             through: :category_categorizables,
             source: :categorizable,
             source_type: 'Product'
    has_many :dashboard_articles,
             -> { select(:id, :title, :status, :slug) },
             through: :category_categorizables,
             source: :categorizable,
             source_type: 'Article'
    has_many :dashboard_projects,
             -> { select(:id, :title, :status, :slug) },
             through: :category_categorizables,
             source: :categorizable,
             source_type: 'Project'

    def localized_title_with_super_category
        super_category ? "#{localized_title} (#{super_category.title})" : localized_title
    end

    def localized_title
        return title2 if I18n.locale == :en && !title2.nil? && !title2.empty?

        title
    end

    def localized_short_title
        title = localized_title
        return if title.nil?

        title.length > 15 ? "#{title[0...15]}..." : title
    end

    def localized_desc
        return description2 if I18n.locale == :en && !description2.nil? && !description2.empty?

        description
    end

    def localized_short_desc
        description = localized_desc
        return if description.nil?

        description.length > 100 ? "#{description[0...100]}..." : description
    end
end
