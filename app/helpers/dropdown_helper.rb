# frozen_string_literal: true

module DropdownHelper
    def dropdown_for(name, is_dropup: false, icon: false, &block)
        Dropdown.new(self, name, is_dropup, icon, block).html
    end

    class Dropdown
        def initialize(view, name, is_dropup, icon, block)
            @view = view
            @name = name
            @is_dropup = is_dropup
            @block = block
            @icon = icon
        end

        def html
            content = safe_join [trigger, menu(block)]

            content_tag :div, content, class: "dropdown #{is_dropup ? 'is-dropup' : ''} #{@icon ? 'localized' : ''}",
                                       data: { controller: 'dropdown', dropdown_active_class: 'is-active' }
        end

        private

        attr_accessor :view, :name, :is_dropup, :block

        delegate :link_to, :button_to, :content_tag, :image_tag, :safe_join, :raw, to: :view

        def trigger
            content_tag :div, class: 'dropdown-trigger' do
                content_tag :button, button, class: 'btn', data: { action: 'click->dropdown#display click@window->dropdown#stopDisplayingWhenOutside' },
                                             aria: { haspopup: 'true', controls: 'dropdown-menu' }
            end
        end

        def localized
            icon = raw '<svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-world" width="16" height="16" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                          <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                          <circle cx="12" cy="12" r="9" />
                          <line x1="3.6" y1="9" x2="20.4" y2="9" />
                          <line x1="3.6" y1="15" x2="20.4" y2="15" />
                          <path d="M11.5 3a17 17 0 0 0 0 18" />
                          <path d="M12.5 3a17 17 0 0 1 0 18" />
                        </svg>'

            content_tag :span, icon, class: 'dropdown-icon localized'
        end

        def button
            icon = raw "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24'
                             stroke-width='2.5' stroke='currentColor' fill='none' stroke-linecap='round'
                             stroke-linejoin='round'>
                            <path stroke='none' d='M0 0h24v24H0z' fill='none'/>
                            <polyline points='6 12 12 18 18 12' />
                        </svg>"

            icon = content_tag :span, icon, class: 'dropdown-icon'

            @icon ? safe_join([localized, name, icon]) : safe_join([name, icon])
        end

        def menu(block)
            content_tag :div,
                        class: 'dropdown-menu',
                        id: 'dropdown-menu',
                        role: 'menu',
                        data: { dropdown_target: 'menu' },
                        &block
        end
    end
end
