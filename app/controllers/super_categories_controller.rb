# frozen_string_literal: true

class SuperCategoriesController < ApplicationController
    before_action :set_super_category, only: %i[show edit update destroy]
    before_action :set_model_name, only: %i[show index]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /super_categories/new
    def new
        @super_category = SuperCategory.new
    end

    # GET /super_categories/1/edit
    def edit; end

    def show
        @categories = if @model_name.nil?
                          @super_category.categories
                      else
                          @super_category.categories.where.associated @model_name
                      end
    end

    def index
        unless @model_name.nil?
            @model_path = model = @model_name.singularize.titleize.constantize
            @uncategorized = model.published.where.missing :categories
            @uncategorized_path = url_for(controller: @model_name, action: :index, uncategorized: true)
        end

        @super_categories = SuperCategory.related_to @model_name
    end

    # POST /super_categories
    def create
        @super_category = SuperCategory.new(super_category_params)

        if @super_category.save
            redirect_to "/#{I18n.locale}/dashboard/categories"
        else
            render :new, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /super_categories/1
    def update
        if @super_category.update(super_category_params)
            redirect_to "/#{I18n.locale}/dashboard/categories"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # DELETE /super_categories/1
    def destroy
        @super_category.destroy

        redirect_to "/#{I18n.locale}/dashboard/categories"
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_super_category
        @super_category = SuperCategory.find(params[:id])
    end

    def set_model_name
        @model_name = params[:model_name] if params[:model_name].in? %w[projects solutions products]
    end

    # Only allow a list of trusted parameters through.
    def super_category_params
        params.require(:super_category).permit :title, :title2, { category_ids: [] }
    end
end
