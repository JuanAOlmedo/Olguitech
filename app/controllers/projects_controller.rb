# frozen_string_literal: true

class ProjectsController < ApplicationController
    before_action :set_project, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /projects
    def index
        @super_categories = SuperCategory.related_to :projects
        @super_category = @super_categories.find do |sc|
            sc.id == params[:super_category_id].to_i
        end || @super_categories.first
    end

    # GET /projects/1
    # Count the number of views of an project. Store in the user's session that
    # the project has been viewed
    def show
        session[:viewed_projects] = [] unless session[:viewed_projects]

        return if @project.id.in? session[:viewed_projects]

        @project.update views: @project.views + 1
        session[:viewed_projects] << @project.id
    end

    # GET /projects/new
    def new
        @project = Project.new
    end

    # GET /projects/1/edit
    def edit; end

    # POST /projects
    # POST /projects.json
    def create
        @project = Project.new(project_params)

        respond_to do |format|
            if @project.save
                format.html do
                    redirect_to @project,
                                notice: 'Artículo creado exitosamente.'
                end
                format.json do
                    render :show, status: :created, location: @project
                end
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json do
                    render json: @project.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # PATCH/PUT /projects/1
    # PATCH/PUT /projects/1.json
    def update
        respond_to do |format|
            if @project.update(project_params)
                format.html do
                    redirect_to @project,
                                notice: 'Artículo actualizdo exitosamente.'
                end
                format.json { render :show, status: :ok, location: @project }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json do
                    render json: @project.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # DELETE /projects/1
    # DELETE /projects/1.json
    def destroy
        @project.destroy
        respond_to do |format|
            format.html do
                redirect_to projects_url,
                            notice: 'Artículo destruido exitosamente.',
                            status: :see_other
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_project
        @project = Project.friendly.find(params[:id])

        authenticate_admin! unless @project.published?
    end

    # Only allow a list of trusted parameters through.
    # Convert status to integer
    def project_params
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
