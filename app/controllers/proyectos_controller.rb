# frozen_string_literal: true

class ProyectosController < ApplicationController
    before_action :set_proyecto, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /proyectos
    # GET /proyectos.json
    def index
        respond_to do |format|
            format.html do
                ordered =
                    Proyecto.ordered(params[:order_by], params[:asc_desc])

                @categories = ordered[0]
                @proyectos = ordered[1]

                @uncategorized = Proyecto.where.missing :categories
            end

            format.json { @proyectos = Proyecto.all }
        end
    end

    # GET /proyectos/1
    def show
        viewed_proyectos = session[:viewed_proyectos]

        return unless viewed_proyectos.nil? || !@proyecto.id.in?(viewed_proyectos)

        @proyecto.views += 1

        session[:viewed_proyectos] = [] if viewed_proyectos.nil?
        session[:viewed_proyectos] << @proyecto.id

        @proyecto.save
    end

    # GET /proyectos/new
    def new
        @proyecto = Proyecto.new
    end

    # GET /proyectos/1/edit
    def edit; end

    # POST /proyectos
    # POST /proyectos.json
    def create
        @proyecto = Proyecto.new(proyecto_params)

        respond_to do |format|
            if @proyecto.save
                format.html do
                    redirect_to @proyecto,
                                notice: 'Artículo creado exitosamente.'
                end
                format.json do
                    render :show, status: :created, location: @proyecto
                end
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json do
                    render json: @proyecto.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # PATCH/PUT /proyectos/1
    # PATCH/PUT /proyectos/1.json
    def update
        respond_to do |format|
            if @proyecto.update(proyecto_params)
                format.html do
                    redirect_to @proyecto,
                                notice: 'Artículo actualizdo exitosamente.'
                end
                format.json { render :show, status: :ok, location: @proyecto }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json do
                    render json: @proyecto.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # DELETE /proyectos/1
    # DELETE /proyectos/1.json
    def destroy
        @proyecto.destroy
        respond_to do |format|
            format.html do
                redirect_to proyectos_url,
                            notice: 'Artículo destruido exitosamente.',
                            status: :see_other
            end
            format.json { head :no_content }
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_proyecto
        @proyecto = Proyecto.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def proyecto_params
        params
            .require(:proyecto)
            .permit(
                :title,
                :title2,
                :content,
                :content2,
                :description,
                :description2,
                { product_ids: [] },
                { category_ids: [] },
                :image
            )
    end
end
