# frozen_string_literal: true

class ProductsController < ApplicationController
    include Articles

    private

    # Only allow a list of trusted parameters through.
    # Convert status to integer
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
              .merge(status: params[:product].fetch(:status, 1).to_i)
    end
end
