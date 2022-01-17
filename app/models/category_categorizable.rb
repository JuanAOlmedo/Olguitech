# frozen_string_literal: true

class CategoryCategorizable < ApplicationRecord
    belongs_to :category
    belongs_to :categorizable, polymorphic: true
end
