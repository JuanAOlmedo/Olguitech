module Getters
    def get_title
        if I18n.locale == :en && self.title2 != '' && self.title2 != nil
            self.title2
        else
            self.title
        end
    end

    def get_short_title
        title = self.get_title
        return title.length > 50 ? title[0...50] + '...' : title
    end

    def get_desc
        if I18n.locale == :en && self.description2 != '' &&
               self.description2 != nil
            self.description2
        else
            self.description
        end
    end

    def get_short_desc
        description = self.get_desc
        return(
            if description.length > 110
                description[0...110] + '...'
            else
                description
            end
        )
    end

    def get_content
        if I18n.locale == :en && !self.content2.empty?
            self.content2
        else
            self.content
        end
    end

    def self.included(base)
        base.extend(ClassMethods)
    end

    module ClassMethods
        def uncategorized
            self.includes(:categories).where(categories: { id: nil })
        end

        def get_ordered(order_by, asc_desc)
            order_by =
                if order_by == 'created_at' || order_by == 'updated_at' ||
                       order_by == 'title' || order_by == 'categories' ||
                       order_by == 'uncategorized'
                    order_by
                else
                    'categories'
                end

            order_by =
                order_by == 'title' && I18n.locale == :en ? 'title2' : order_by

            asc_desc =
                asc_desc == 'asc' || asc_desc == 'desc' ? asc_desc : :desc

            if order_by == 'categories'
                categories = Category.includes(self.model_name.plural).where.not(self.model_name.plural => { id: nil })
            elsif order_by == 'uncategorized'
                ordered = self.uncategorized.order created_at: asc_desc
            else
                ordered = self.all.order order_by => asc_desc
            end

            return categories, ordered
        end
    end
end
