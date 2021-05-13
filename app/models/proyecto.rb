class Proyecto < ApplicationRecord
    has_rich_text :content
    has_rich_text :content2
    has_one_attached :image
end
