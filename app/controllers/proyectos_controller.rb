class ProyectosController < ApplicationController
    before_action :set_proyecto, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: %i[index show]

    # GET /proyectos
    def index
        order_by =
            if params[:order_by] == 'created_at' ||
                   params[:order_by] == 'updated_at' ||
                   params[:order_by] == 'title' ||
                   params[:order_by] == 'categories'
                params[:order_by]
            else
                'categories'
            end
        order_by =
            order_by == 'title' && I18n.locale == :en ? 'title2' : order_by
        asc_desc =
            if params[:asc_desc] == 'asc' || params[:asc_desc] == 'desc'
                params[:asc_desc]
            else
                'desc'
            end

        if order_by == 'categories'
            @categories = Category.all.order(created_at: :desc)
        else
            @proyectos = Proyecto.all.order(order_by => asc_desc)
        end

        @uncategorized = []

        Proyecto.all.each do |proyecto|
            @uncategorized << proyecto if proyecto.categories.empty?
        end
    end

    # GET /proyectos/1
    def show; end

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
                if products != nil
                    products.each_with_index do |product, i|
                        products[i] = Product.find(product.to_i)
                        if !@proyecto.products.include? products[i]
                            products[i].proyectos << @proyecto
                        end
                    end
                else
                    products = []
                end

                @proyecto.products.each do |product|
                    if !products.include? product
                        @proyecto
                            .product_referenceables
                            .find_by(product_id: product.id)
                            .destroy
                    end
                end

                if categories != nil
                    categories.each_with_index do |category, i|
                        categories[i] = Category.find(category.to_i)
                        if !@proyecto.categories.include? categories[i]
                            categories[i].proyectos << @proyecto
                        end
                    end
                else
                    categories = []
                end

                @proyecto.categories.each do |category|
                    if !categories.include? category
                        @proyecto
                            .category_categorizables
                            .find_by(category_id: category.id)
                            .destroy
                    end
                end

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
                            notice: 'Artículo destruido exitosamente.'
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
                :image,
            )
    end
end
