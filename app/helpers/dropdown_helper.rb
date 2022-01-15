module DropdownHelper
    def dropdown_for(name, is_dropup = false, &block)
        Dropdown.new(self, name, is_dropup, block).html
    end

    private

    class Dropdown
        def initialize(view, name, is_dropup, block)
            @view, @name, @is_dropup, @block = view, name, is_dropup, block
        end

        def html
            content = safe_join [ trigger, menu(block) ]
    
            content_tag :div, content, class: "dropdown #{is_dropup ? "is-dropup" : ""}", data: { controller: "dropdown", dropdown_active_class: "is-active" }
        end

        private

        attr_accessor :view, :name, :is_dropup, :block

        delegate :link_to, :button_to, :content_tag, :image_tag, :safe_join, :raw, to: :view

        def trigger
            content_tag :div, class: "dropdown-trigger" do
                content_tag :button, button, class: "btn", data: { action: "click->dropdown#display" }, aria: { haspopup: "true", controls: "dropdown-menu" }
            end
        end

        def button
            icon = raw "<svg xmlns='http://www.w3.org/2000/svg' width='16' height='16' viewBox='0 0 24 24' stroke-width='2.5' stroke='currentColor' fill='none' stroke-linecap='round' stroke-linejoin='round'>
                            <path stroke='none' d='M0 0h24v24H0z' fill='none'/>
                            <polyline points='6 12 12 18 18 12' />
                        </svg>"

            icon = content_tag :span, icon, class: "dropdown-icon"

            safe_join [name, icon]
        end
    
        def menu(block)
            content_tag :div, class: "dropdown-menu", id: "dropdown-menu", role: "menu", data: { dropdown_target: "menu" }, &block
        end
    end
end
