# frozen_string_literal: true

module Getters
    def get_title
        return title2 if I18n.locale == :en && !title2.empty? && !title2.nil?

        title
    end

    def get_short_title
        title = get_title
        return if title.nil?

        title.length > 50 ? "#{title[0...50]}..." : title
    end

    def get_desc
        return description2 if I18n.locale == :en && !description2.empty? && !description2.nil?

        description
    end

    def get_short_desc
        description = get_desc
        return if description.nil?

        description.length > 110 ? "#{description[0...110]}..." : description
    end

    def get_content
        return content2 if I18n.locale == :en && !content2.empty?

        content
    end

    def self.included(base)
        base.extend(ClassMethods)
    end

    module ClassMethods
        def uncategorized
            includes(:categories).where(categories: { id: nil })
        end

        def get_ordered(order_by, asc_desc)
            order_by =
                if %w[created_at updated_at title categories uncategorized].include? order_by
                    order_by
                else
                    'categories'
                end

            order_by =
                order_by == 'title' && I18n.locale == :en ? 'title2' : order_by

            asc_desc = %w[asc desc].include?(asc_desc) ? asc_desc : :desc

            case order_by
            when 'categories'
                categories = Category.related_to model_name.plural
            when 'uncategorized'
                ordered = uncategorized.order created_at: asc_desc
            else
                ordered = all.order order_by => asc_desc
            end

            [categories, ordered]
        end
    end
end
