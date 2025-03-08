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

    # GET /super_categories/1
    # If the model name is set, fetch categories related to the model
    def show
        @categories = if @model_name.nil?
                          @super_category.categories
                      else
                          @super_category.categories.where.associated @model_name.to_sym
                      end
    end

    # GET /super_categories
    # If the model name is set, fetch super categories related to the model
    def index
        if @model_name.nil?
            @super_categories = SuperCategory.all
        else
            model = @model_name.singularize.titleize.constantize
            @model_path = model
            @uncategorized = model.published.where.missing :categories
            @uncategorized_path = url_for(controller: @model_name, action: :index, uncategorized: true)

            @super_categories = SuperCategory.related_to @model_name
        end
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

        respond_to do |format|
            format.html do
                redirect_to "/#{I18n.locale}/dashboard/categories",
                            notice: 'Super Categoría destruída exitosamente.',
                            status: :see_other
            end
            format.json { head :see_other }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_super_category
        @super_category = SuperCategory.find(params[:id])
    end

    # When accessing super_categories from solutions, products or projects index,
    # only super categories and categories relevant to those models should be displayed.
    # Set the model name for the current request.
    def set_model_name
        @model_name = params[:model_name] if params[:model_name].in? %w[projects solutions products]
    end

    # Only allow a list of trusted parameters through.
    def super_category_params
        params.require(:super_category).permit :title, :title2, { category_ids: [] }
    end
end
