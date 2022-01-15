class Product < ApplicationRecord
    include Getters
    include Mailable

    extend FriendlyId
    friendly_id :title, use: :slugged

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

    after_create :send_mail

    def base_uri
        Rails.application.routes.url_helpers.product_path(self, locale: I18n.locale)
    end
end
