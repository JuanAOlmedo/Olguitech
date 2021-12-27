module CardsHelper
    def cards_for(array)
        Cards.new(self, array).html
    end

    class Cards
        def initialize(view, array)
            @view, @array = view, array
            @uid = SecureRandom.hex(6)
        end

        def html
            unless @array.length == 1
                content = grid(@array)
            else
                content = card_single(@array[0])
            end

            content_tag :div, content, id: uid, class: 'cards-holder centered'
        end

        private

        attr_accessor :view, :array, :uid
        delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view

        def grid(array)
            content = []

            rand_num = @array.length.even? ? rand(0..1) : 1
            rand_num2 = @array.length.even? ? rand(3..5) : 10

            if rand_num == 0
                @last_row1, @last_row2 = rand_num2, 1
            else
                @last_row1, @last_row2 = 1, rand_num2
            end

            array.each do |element|
                if element
                    content << card(element, array.find_index(element).even?)
                end
            end

            content = safe_join content

            content_tag :div,
                        content,
                        class: 'grid',
                        style:
                            "grid-template-rows: repeat(#{[@last_row1, @last_row2].max}, 0.2rem);"
        end

        def card_single(element)
            content = safe_join [img(element), card_content(element)]

            content_tag :div, content, class: 'card card-single centered still'
        end

        def card(element, is_even)
            content = safe_join [img(element), card_content(element)]

            grid_row =
                if is_even
                    "#{@last_row1} / #{@last_row1 + 19}"
                else
                    "#{@last_row2} / #{@last_row2 + 19}"
                end

            if is_even
                @last_row1 += 20
            else
                @last_row2 += 20
            end

            content_tag :div,
                        content,
                        class: 'card still',
                        style:
                            "grid-column: #{is_even ? '1' : '2'};
                                grid-row: #{grid_row};"
        end

        def img(element)
            if element.image.attached?
                ActiveStorage::Current.url_options = {
                    locale: I18n.locale,
                    only_path: true
                }

                image_tag element.image.variant(resize_to_limit: [40, 40]),
                          data: {
                              src: element.image.url
                          },
                          class: 'lazy',
                          alt: element.image.filename
            end
        end

        def card_content(element)
            title = content_tag :h2, element.get_short_title, class: 'title'
            desc = content_tag :p, element.get_short_desc, class: 'big-text'
            link = link_to 'Ver más', element.base_uri, class: 'btn'

            content = safe_join [title, desc, link]

            content_tag :div, content
        end
    end
end
