# frozen_string_literal: true

json.array! @newsletters, partial: 'newsletters/newsletter', as: :newsletter
