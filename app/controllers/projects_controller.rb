# frozen_string_literal: true

class ProjectsController < ApplicationController
    include Articles

    private

    # Only allow a list of trusted parameters through.
    # Convert status to integer
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
              .merge(status: params[:project].fetch(:status, 1).to_i)
    end
end
