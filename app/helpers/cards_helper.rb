# frozen_string_literal: true

# Creates the cards shown for example on main, with the alternative of using
# the cards shown for products
#
# Accepts the array of instances which will be turned to cards and the option
# to display the instances' images
module CardsHelper
    def cards_for(array, image: true)
        Cards.new(self, array, image).html
    end

    def alternative_cards_for(array, image: true)
        Cards.new(self, array, image).alternative_html
    end

    def compact_cards_for(array, image: true)
        Cards.new(self, array, image).compact_html
    end

    # Accepts an array and the option of showing an image, then returns the html
    # to show the cards
    class Cards
        def initialize(view, array, image)
            @view = view
            @array = array.to_a
            @image = image
        end

        # Defines the 'normal' cards shown for solutions and projects
        def html
            content = @array.length != 1 ? grid : card_single(@array.first)

            tag.div content, class: 'cards-holder centered'
        end

        # Defines the 'alternative' cards shown for products
        def alternative_html
            # When the margin is :none, both sides will have automatic margins.
            # This is the case when the card is alone
            margin = @array.length != 1 ? %i[left right].sample : :none

            @array.map! do |element|
                margin = margin == :left ? :right : :left unless margin == :none
                alternative_card(element, margin)
            end

            tag.div safe_join(@array), class: 'cards-holder centered'
        end

        def compact_html
            @array.map! do |element|
                compact_card(element)
            end

            tag.div safe_join(@array), class: 'cards-holder centered', style: 'text-align: left;'
        end

        private

        attr_accessor :view, :array

        delegate :link_to, :tag, :image_for, :safe_join, :url_for, to: :view

        # Creates a grid, randomly assigns which of the two columns will start first,
        # given by the variable column, and the offset the other will start with.
        def grid
            column = %i[left right].sample

            @last_row = { left: 1, right: 1 }
            # Define offset for one of the columns
            @last_row[column] = @array.length.even? ? rand(3..5) : 10

            @array.map! do |element|
                column = column == :left ? :right : :left
                card(element, column) if element
            end

            tag.div safe_join(@array), class: 'grid', style: "grid-template-rows:\
                                                              repeat(#{@last_row.max[1]}, 0.2rem);"
        end

        # Generate a single, centered card
        def card_single(element)
            tag.div safe_join([img(element), card_content(element)]), class: 'card card-single centered'
        end

        # The cards are set to occupy 20 rows of the grid each. The row at which they
        # end is given by last_row[:left] or last_row[:right] depending on if they are
        # in the left or the right column
        def card(element, column)
            content = safe_join [img(element), card_content(element)]

            grid_row = "#{@last_row[column]} / #{@last_row[column] + 19}"
            @last_row[column] += 20

            tag.div content, class: 'card',
                             style: "grid-column: #{column == :left ? '1' : '2'};\
                                     grid-row: #{grid_row};"
        end

        # The alternative cards have a random margin on one of theit sides given by
        # random_margin and an automatic margin on the other side. If rand_margin is
        # :none, both sides will have automatic margins.
        def alternative_card(element, rand_margin)
            content = safe_join [img(element), card_content(element)]

            margin = { left: 'auto', right: 'auto' }
            margin[rand_margin] = "#{rand(3.0..7.0)}%"

            tag.div content, class: 'alternative-card',
                             style: "margin-left: #{margin[:left]};\
                                     margin-right: #{margin[:right]};"
        end

        # Return the image if the variable @image is provided
        def img(element)
            return '' unless @image && element.image.attached?

            image_for element.image, resize: [720, 720], alt: element.image.filename
        end

        # The content of the card itself (title, description and link)
        def card_content(element)
            tag.div do
                tag.h2(element.localized_short_title, class: 'title') +
                    tag.p(element.localized_short_desc, class: 'big-text') +
                    link_to(I18n.t('general.see_more'), element, class: 'btn')
            end
        end

        def compact_card(element)
            tag.div safe_join([img(element), compact_card_content(element)]), class: 'compact-card'
        end

        def compact_card_content(element)
            tag.div do
                tag.h3(element.localized_title) +
                    tag.p(element.localized_desc) +
                    link_to(I18n.t('general.see_more'), element, class: 'btn')
            end
        end

    end
end
