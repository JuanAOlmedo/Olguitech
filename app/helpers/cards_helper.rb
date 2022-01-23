# frozen_string_literal: true

module CardsHelper
    def cards_for(array, image: true)
        Cards.new(self, array, image).html
    end

    def alternative_cards_for(array, image: true)
        Cards.new(self, array, image).alternative_html
    end

    class Cards
        def initialize(view, array, image)
            @view = view
            @array = array
            @image = image
            @uid = SecureRandom.hex(6)
        end

        def html
            content = @array.length != 1 ? grid(@array) : card_single(@array[0])

            content_tag :div, content, id: uid, class: 'cards-holder centered'
        end

        def alternative_html
            if @array.length != 1
                content = []
                starts_left = [true, false].sample

                array.each do |element|
                    next unless element

                    content <<
                        alternative_card(
                            element,
                            array.find_index(element).even?,
                            starts_left
                        )
                end

                content = safe_join content
            else
                content = alternative_card_single(@array[0])
            end

            content_tag :div, content, id: uid, class: 'cards-holder centered'
        end

        private

        attr_accessor :view, :array, :uid

        delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view

        def grid(array)
            content = []

            starts_right = @array.length.even? ? [false, true].sample : true
            rand_num = @array.length.even? ? rand(3..5) : 10

            if starts_right
                @last_row1 = rand_num
                @last_row2 = 1
            else
                @last_row1 = 1
                @last_row2 = rand_num
            end

            array.each do |element|
                content << card(element, array.find_index(element).even?) if element
            end

            content = safe_join content

            content_tag :div, content, class: 'grid',
                                       style: "grid-template-rows: repeat(#{[@last_row1, @last_row2].max}, 0.2rem);"
        end

        def card_single(element)
            content = safe_join [img(element), card_content(element)]

            content_tag :div, content, class: 'card card-single centered still'
        end

        def card(element, is_even)
            content = safe_join [img(element), card_content(element)]

            if is_even
                grid_row = "#{@last_row1} / #{@last_row1 + 19}"
                @last_row1 += 20
            else
                grid_row = "#{@last_row2} / #{@last_row2 + 19}"
                @last_row2 += 20
            end

            content_tag :div, content, class: 'card still',
                                       style: "grid-column: #{is_even ? '1' : '2'}; grid-row: #{grid_row};"
        end

        def alternative_card_single(element)
            content = safe_join [img(element), card_content(element)]

            content_tag :div, content, class: 'alternative-card centered still'
        end

        def alternative_card(element, is_even, starts_left)
            content = safe_join [img(element), card_content(element)]

            rand_num = "#{rand(3.0..7.0)}%"

            margin_left = !is_even ^ starts_left ? 'auto' : rand_num
            margin_right = is_even ^ starts_left ? 'auto' : rand_num

            content_tag :div, content, class: 'alternative-card still',
                                       style: "margin-left: #{margin_left};
                                               margin-right: #{margin_right};"
        end

        def img(element)
            return unless @image && element.image.attached?

            image_tag element.image.variant(resize_to_limit: [40, 40]),
                      data: { src:
                                  Rails.application.routes.url_helpers.rails_blob_url(
                                      element.image,
                                      locale: I18n.locale,
                                      only_path: true
                                  ) },
                      class: 'lazy',
                      alt: element.image.filename
        end

        def card_content(element)
            title = content_tag :h2, element.localized_short_title, class: 'title'
            desc = content_tag :p, element.localized_short_desc, class: 'big-text'
            link = link_to I18n.t('general.see_more'), element.base_uri, class: 'btn'

            content = safe_join [title, desc, link]

            content_tag :div, content
        end
    end
end
