# frozen_string_literal: true

class Project < ApplicationRecord
    include Getters
    include Mailable

    extend FriendlyId
    friendly_id :title, use: :slugged

    enum :status, %i[published drafted trashed], default: :drafted

    has_rich_text :content
    has_rich_text :content2
    has_one_attached :image

    has_many :product_referenceables, as: :referenceable, dependent: :destroy
    has_many :products, through: :product_referenceables, as: :referenceable

    has_many :category_categorizables, as: :categorizable, dependent: :destroy
    has_many :categories, through: :category_categorizables, as: :categorizable

    # Send mail after the project has been created or edited as published
    # and if no mail has been sent before
    after_save_commit :send_mail, if: :published?, unless: :newsletter_sent
end
