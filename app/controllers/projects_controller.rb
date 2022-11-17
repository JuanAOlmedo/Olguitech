# frozen_string_literal: true

class ProjectsController < ApplicationController
    before_action :set_project, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /projects
    # GET /projects.json
    def index
        respond_to do |format|
            format.html do
                @categories, @projects =
                    Project.ordered(params[:order_by], params[:asc_desc])

                @uncategorized = Project.published.where.missing :categories
            end

            format.json { @projects = Project.published.all }
        end
    end

    # GET /projects/1
    def show
        viewed_projects = session[:viewed_projects]

        return unless viewed_projects.nil? || !@project.id.in?(viewed_projects)

        @project.views += 1

        session[:viewed_projects] = [] if viewed_projects.nil?
        session[:viewed_projects] << @project.id

        @project.save
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
    def project_params
        project_params = params
                         .require(:project)
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
        project_params[:status] = project_params[:status].to_i if project_params[:status]
        project_params
    end
end
