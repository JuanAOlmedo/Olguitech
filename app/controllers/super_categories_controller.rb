# frozen_string_literal: true

MODEL_MAP = {
    'projects' => Project,
    'solutions' => Solution,
    'products' => Product
}.freeze

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
    def show
        # Si @model_name está seteado, solo incluir categorías relacionadas a ese modelo
        if @model_name.nil?
            redirect_to root_path, alert: 'Operación no permitida', status: :see_other
        else
            @categories = @super_category.categories
                                         .where.associated(@model_name.to_sym)
                                         .where(@model_name => { status: 0 })
                                         .includes(@model_name => { image_attachment: :blob })
                                         .distinct
                                         .load
        end
    end

    # GET /super_categories
    # If the model name is set, fetch super categories related to the model
    def index
        if @model_name.nil?
            @super_categories = SuperCategory.all
        else
            @uncategorized = @model_class.published.where.missing :categories
            @uncategorized_path = url_for(controller: @model_name, action: :index, uncategorized: true)

            @super_categories = SuperCategory.related_to(@model_name)
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
        @model_class = MODEL_MAP[params[:model_name]]
        @model_name = params[:model_name] if @model_class
    end

    # Only allow a list of trusted parameters through.
    def super_category_params
        params.require(:super_category).permit :title, :title2, { category_ids: [] }
    end
end
