# frozen_string_literal: true

class SuperCategoriesController < ApplicationController
    before_action :set_super_category, only: %i[edit update destroy]
    before_action :authenticate_admin!, except: %i[show]

    # GET /super_categories/1
    def show
        if %w[Article Project Product].include? params[:related_to]
            @model_name = "#{params[:related_to].downcase}s".to_sym

            @super_categories = SuperCategory.related_to Object.const_get(params[:related_to])
            @super_category = @super_categories.find { |sc| sc.id == params[:id].to_i }
        else
            set_super_category
        end
    end

    # GET /super_categories/new
    def new
        @super_category = SuperCategory.new
    end

    # GET /super_categories/1/edit
    def edit; end

    # POST /super_categories
    def create
        @super_category = SuperCategory.new(super_category_params)

        respond_to do |format|
            if @super_category.save
                format.html { redirect_to categories_dashboard_path }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
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

    # DELETE /super_categories/1 or /super_categories/1.json
    def destroy
        @super_category.destroy

        redirect_to super_categories_url
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_super_category
        @super_category = SuperCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def super_category_params
        params.require(:super_category).permit :title, :title2, { category_ids: [] }
    end
end
