# frozen_string_literal: true

# Creates the cards shown for example on main, with the alternative of using
# the cards shown for products
#
# Accepts the array of instances which will be turned to cards and the option
# to display the instances' images
module CardsHelper
    def cards_for(array, image: true, webp: false)
        Cards.new(self, array, image, webp).html
    end

    def alternative_cards_for(array, image: true, webp: false)
        Cards.new(self, array, image, webp).alternative_html
    end

    # Accepts an array and the option of showing an image, then returns the html
    # to show the cards
    class Cards
        def initialize(view, array, image, webp)
            @view = view
            @array = array
            @image = image
            @webp = webp
            @uid = SecureRandom.hex(4)
        end

        # Defines the 'normal' cards shown for articles and projects
        def html
            content = @array.length != 1 ? grid(@array) : card_single(@array.first)

            content_tag :div, content, id: uid, class: 'cards-holder centered'
        end

        # Defines the 'alternative' cards shown for products
        def alternative_html
            if @array.length != 1
                content = []
                margin_left = [true, false].sample

                array.each do |element|
                    content << alternative_card(element, margin_left)
                    margin_left = !margin_left
                end
            else
                content = [alternative_card_single(@array.first)]
            end

            content_tag :div, safe_join(content), id: uid, class: 'cards-holder centered'
        end

        private

        attr_accessor :view, :array, :uid

        delegate :link_to, :content_tag, :image_tag, :safe_join, :url_for, to: :view

        # Creates a grid, randomly assigns which of the two columns will start first,
        # given by the variable starts_left, and the offset the other will start with.
        def grid(array)
            starts_left = [false, true].sample

            @last_row = { left: 1, right: 1 }
            # Define offset for one of the columns
            @last_row[starts_left ? :right : :left] = @array.length.even? ? rand(3..5) : 10

            content = []
            array.each do |element|
                content << card(element, starts_left ? :left : :right) if element
                starts_left = !starts_left
            end

            content_tag :div, safe_join(content), class: 'grid',
                                                  style: "grid-template-rows:\
                                                          repeat(#{@last_row.max[1]}, 0.2rem);"
        end

        def card_single(element)
            content = safe_join [img(element), card_content(element)]

            content_tag :div, content, class: 'card card-single centered still'
        end

        # The cards are set to occupy 20 rows of the grid each. The row at which they
        # end is given by last_row_left or last_row_right depending on if they are in
        # the left or the right column
        def card(element, column)
            content = safe_join [img(element), card_content(element)]

            grid_row = "#{@last_row[column]} / #{@last_row[column] + 19}"
            @last_row[column] += 20

            content_tag :div, content, class: 'card still',
                                       style: "grid-column: #{column == :left ? '1' : '2'};\
                                               grid-row: #{grid_row};"
        end

        def alternative_card_single(element)
            content = safe_join [img(element), card_content(element)]

            content_tag :div, content, class: 'alternative-card centered still'
        end

        # The alternative cards have a random margin on each side given by
        # random_margin.
        def alternative_card(element, margin_left)
            content = safe_join [img(element), card_content(element)]

            rand_margin = "#{rand(3.0..7.0)}%"

            margin_left = margin_left ? rand_margin : 'auto'
            margin_right = margin_left ? 'auto' : rand_margin

            content_tag :div, content, class: 'alternative-card still',
                                       style: "margin-left: #{margin_left};\
                                               margin-right: #{margin_right};"
        end

        def img(element)
            return unless @image && element.image.attached?

            options = { saver: { quality: 80 }, resize_to_limit: [720, 720] }
            options.merge!({ convert: 'webp' }) if @webp

            image_tag element.image.variant(options),
                      loading: 'lazy',
                      alt: element.image.filename
        end

        def card_content(element)
            title = content_tag :h2, element.localized_short_title, class: 'title'
            desc = content_tag :p, element.localized_short_desc, class: 'big-text'
            link = link_to I18n.t('general.see_more'), element, class: 'btn'

            content_tag :div, safe_join([title, desc, link])
        end
    end
end
