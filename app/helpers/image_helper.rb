# frozen_string_literal: true

module ImageHelper
    def image_for(image, options = {})
        img_options = { saver: { quality: 80 }, resize_to_limit: options[:resize], convert: 'webp' }
        options.merge!({
                           loading: 'lazy',
                           data: { nowebpsrc: url_for(image.variant(img_options.except(:convert))) }
                       })

        image_tag image.variant(img_options), options.except(:resize)
    end
end
