class ProyectosController < ApplicationController
    before_action :set_proyecto, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /proyectos
    def index
        ordered = Proyecto.get_ordered(params[:order_by], params[:asc_desc])

        @categories = ordered[0]
        @proyectos = ordered[1]

        @uncategorized = Proyecto.uncategorized
    end

    # GET /proyectos/1
    def show
        @proyecto.views = 0 if @proyecto.views == nil

        if session[:viewed_proyectos] == nil
            @proyecto.views += 1

            session[:viewed_proyectos] = [@proyecto.id]
        elsif !@proyecto.id.in? session[:viewed_proyectos].to_a
            @proyecto.views += 1

            a = session[:viewed_proyectos].to_a
            a << @proyecto.id
            session[:viewed_proyectos] = a
        end

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
        parameters = proyecto_params
        products = parameters[:products]
        parameters.delete(:products)

        categories = parameters[:categories]
        parameters.delete(:categories)

        @proyecto = Proyecto.new(parameters)

        @proyecto.change_categories_and_products(categories, products)

        respond_to do |format|
            if @proyecto.save
                format.html do
                    redirect_to @proyecto,
                                notice: 'Artículo creado exitosamente.'
                end
                format.json do
                    render :show, status: :created, location: @proyecto
                end

                @users = User.all.where(newsletter: true)

                @users.each do |user|
                    ArticlesMailer.article(user, @proyecto).deliver_later
                end
            else
                format.html { render :new }
                format.json do
                    render json: @proyecto.errors, status: :unprocessable_entity
                end
            end
        end
    end

    # PATCH/PUT /proyectos/1
    # PATCH/PUT /proyectos/1.json
    def update
        parameters = proyecto_params
        products = parameters[:products]
        parameters.delete(:products)

        categories = parameters[:categories]
        parameters.delete(:categories)

        respond_to do |format|
            if @proyecto.update(parameters)
                @proyecto.change_categories_and_products(categories, products)

                format.html do
                    redirect_to @proyecto,
                                notice: 'Artículo actualizdo exitosamente.'
                end
                format.json { render :show, status: :ok, location: @proyecto }
            else
                format.html { render :edit }
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
        @proyecto = Proyecto.find(params[:id])
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
                { products: [] },
                { categories: [] },
                :image
            )
    end
end
