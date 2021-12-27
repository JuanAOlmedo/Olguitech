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
            array1 =
                @array.select { |element| @array.find_index(element).even? }
            array2 = @array.select { |element| @array.find_index(element).odd? }

            rand_num = @array.length.even? ? rand(0..1) : 1

            content =
                safe_join [
                              grid(array1, rand_num == 0 ? true : false),
                              grid(array2, rand_num == 1 ? true : false)
                          ]

            content_tag :div, content, id: uid, class: 'cards-holder centered'
        end

        private

        attr_accessor :view, :array, :uid
        delegate :link_to, :content_tag, :image_tag, :safe_join, to: :view

        def grid(array, has_padding)
            content = []

            content << content_tag(:div, "", style: "height: #{rand(3.00..6.00)}rem;") if has_padding

            array.each { |element| content << card(element) if element }

            content = safe_join content

            content_tag :div, content, class: 'grid'
        end

        def card(element)
            content = safe_join [img(element), card_content(element)]

            content_tag :div, content, class: 'card still'
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
            title = content_tag :h2, element.get_title, class: 'title'
            desc = content_tag :p, element.get_desc, class: 'big-text'
            link = link_to 'Ver más', element.base_uri, class: 'btn'

            content = safe_join [title, desc, link]

            content_tag :div, content
        end
    end
end
