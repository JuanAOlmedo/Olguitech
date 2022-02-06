# frozen_string_literal: true

module Getters
    def localized_title
        return title2 if I18n.locale == :en && !title2.nil? && !title2.empty?

        title
    end

    def localized_short_title
        title = localized_title
        return if title.nil?

        title.length > 50 ? "#{title[0...50]}..." : title
    end

    def localized_desc
        return description2 if I18n.locale == :en && !description2.nil? && !description2.empty?

        description
    end

    def localized_short_desc
        description = localized_desc
        return if description.nil?

        description.length > 110 ? "#{description[0...110]}..." : description
    end

    def localized_content
        return content2 if I18n.locale == :en && !content2.empty?

        content
    end

    def self.included(base)
        base.extend(ClassMethods)
    end

    module ClassMethods
        def ordered(order_by, asc_desc)
            order_by = test_order_by order_by
            asc_desc = %w[asc desc].include?(asc_desc) ? asc_desc : :desc

            return_ordered(order_by, asc_desc)
        end

        private

        def test_order_by(order_by)
            order_by =
                if %w[created_at updated_at title categories uncategorized].include? order_by
                    order_by
                else
                    'categories'
                end

            order_by == 'title' && I18n.locale == :en ? 'title2' : order_by
        end

        def return_ordered(order_by, asc_desc)
            case order_by
            when 'categories'
                categories = Category.where.associated model_name.plural.to_sym
            when 'uncategorized'
                ordered = where.missing(:categories).order created_at: asc_desc
            else
                ordered = all.order order_by => asc_desc
            end

            [categories, ordered]
        end
    end
end
