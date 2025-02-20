# frozen_string_literal: true

class SolutionsController < ApplicationController
    before_action :set_solution, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /solutions
    def index
        @super_categories = SuperCategory.related_to :solutions
        @super_category = @super_categories.find do |sc|
            sc.id == params[:super_category_id].to_i
        end || @super_categories.first
    end

    # GET /solutions/1
    # GET /solutions/1.json
    # Count the number of views of an solution. Store in the user's session that
    # the solution has been viewed
    def show
        session[:viewed_solutions] = [] unless session[:viewed_solutions]

        return if @solution.id.in? session[:viewed_solutions]

        @solution.update views: @solution.views + 1
        session[:viewed_solutions] << @solution.id
    end

    # GET /solutions/new
    def new
        @solution = Solution.new
    end

    # GET /solutions/1/edit
    def edit; end

    # POST /solutions
    # POST /solutions.json
    def create
        @solution = Solution.new(solution_params)

        respond_to do |format|
            if @solution.save
                format.html do
                    redirect_to @solution, notice: 'Artículo creado exitosamente.'
                end
                format.json do
                    render :show, status: :created, location: @solution
                end
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json do
                    render json: @solution.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # PATCH/PUT /solutions/1
    # PATCH/PUT /solutions/1.json
    def update
        respond_to do |format|
            if @solution.update(solution_params)
                format.html do
                    redirect_to @solution,
                                notice: 'Artículo actualizado exitosamente.'
                end
                format.json { render :show, status: :ok, location: @solution }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json do
                    render json: @solution.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # DELETE /solutions/1
    # DELETE /solutions/1.json
    def destroy
        @solution.destroy
        respond_to do |format|
            format.html do
                redirect_to solutions_url,
                            notice: 'Artículo destruido exitosamente.',
                            status: :see_other
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_solution
        @solution = Solution.friendly.find(params[:id])

        authenticate_admin! unless @solution.published?
    end

    # Only allow a list of trusted parameters through.
    # Convert status to integer
    def solution_params
        params.require(:solution)
              .permit(:title,
                      :title2,
                      :content,
                      :content2,
                      :description,
                      :description2,
                      { product_ids: [] },
                      { category_ids: [] },
                      :image,
                      :status)
              .merge(status: params[:solution].fetch(:status, 1).to_i)
    end
end
