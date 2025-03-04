# frozen_string_literal: true

# Model used to set up relations between products and solutions or projects
class ProductReferenceable < ApplicationRecord
    belongs_to :product
    belongs_to :referenceable, polymorphic: true
end
