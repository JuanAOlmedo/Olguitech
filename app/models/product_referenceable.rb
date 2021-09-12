class ProductReferenceable < ApplicationRecord
    belongs_to :product
    belongs_to :referenceable, polymorphic: true
end
