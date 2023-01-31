# frozen_string_literal: true

class SuperCategoriesController < ApplicationController
    before_action :set_super_category, only: %i[edit update destroy]
    before_action :authenticate_admin!, except: %i[show]

    # GET /super_categories/1 or /super_categories/1.json
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

    # POST /super_categories or /super_categories.json
    def create
        @super_category = SuperCategory.new(super_category_params)

        respond_to do |format|
            if @super_category.save
                format.html do
                    redirect_to super_category_url(@super_category),
                                notice: 'Super category was successfully created.'
                end
                format.json { render :show, status: :created, location: @super_category }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @super_category.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /super_categories/1 or /super_categories/1.json
    def update
        respond_to do |format|
            if @super_category.update(super_category_params)
                format.html do
                    redirect_to super_category_url(@super_category),
                                notice: 'Super category was successfully updated.'
                end
                format.json { render :show, status: :ok, location: @super_category }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @super_category.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /super_categories/1 or /super_categories/1.json
    def destroy
        @super_category.destroy

        respond_to do |format|
            format.html do
                redirect_to super_categories_url,
                            notice: 'Super category was successfully destroyed.'
            end
            format.json { head :no_content }
        end
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
