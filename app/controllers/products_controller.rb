# frozen_string_literal: true

class ProductsController < ApplicationController
    include Articles

    private

    # Only allow a list of trusted parameters through.
    def article_params
        params.require(:product)
              .permit(
                  :title,
                  :title2,
                  :description,
                  :description2,
                  :content,
                  :content2,
                  { solution_ids: [] },
                  { project_ids: [] },
                  { category_ids: [] },
                  :image,
                  :status
              )
    end
end
