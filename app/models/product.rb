# frozen_string_literal: true

class Product < ApplicationRecord
    include Getters
    include Mailable

    extend FriendlyId
    friendly_id :title, use: :slugged

    enum :status, %i[published drafted trashed], default: :drafted

    has_rich_text :content
    has_rich_text :content2

    has_many :product_referenceables, dependent: :destroy
    has_many :articles,
             through: :product_referenceables,
             source: :referenceable,
             source_type: 'Article'
    has_many :projects,
             through: :product_referenceables,
             source: :referenceable,
             source_type: 'Project'

    has_one_attached :image

    has_many :category_categorizables, as: :categorizable, dependent: :destroy
    has_many :categories, through: :category_categorizables, as: :categorizable

    # Send mail after the product has been created or edited as published
    # and if no mail has been sent before
    after_save_commit :send_mail, if: :published?, unless: :newsletter_sent
end
