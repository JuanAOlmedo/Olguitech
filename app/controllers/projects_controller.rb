# frozen_string_literal: true

class ProjectsController < ApplicationController
    include Articles

    private

    # Only allow a list of trusted parameters through.
    def article_params
        params.require(:project)
              .permit(
                  :title,
                  :title2,
                  :content,
                  :content2,
                  :description,
                  :description2,
                  { product_ids: [] },
                  { category_ids: [] },
                  :image,
                  :status
              )
    end
end
