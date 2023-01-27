# frozen_string_literal: true

class Interest < ApplicationRecord
    belongs_to :contacto
    belongs_to :record, polymorphic: true
end
