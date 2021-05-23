class ProyectosController < ApplicationController
  before_action :set_proyecto, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin!, except: [:index, :show]

  # GET /proyectos
  def index
    @proyectos = Proyecto.all.order(created_at: :desc)
  end

  # GET /proyectos/1
  def show
  end

  # GET /proyectos/new
  def new
    @proyecto = Proyecto.new
  end

  # GET /proyectos/1/edit
  def edit
  end

  # POST /proyectos
  # POST /proyectos.json
  def create
    parameters = proyecto_params
    products = parameters[:products]
    parameters.delete(:products)

    @proyecto = Proyecto.new(parameters)

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

    respond_to do |format|
      if @proyecto.save
        format.html { redirect_to @proyecto, notice: 'Artículo creado exitosamente.' }
        format.json { render :show, status: :created, location: @proyecto }

        @users = User.all.where(newsletter: true)
    
        @users.each do |user|
          ArticlesMailer.article(user, @proyecto).deliver_later
        end
      else
        format.html { render :new }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proyectos/1
  # PATCH/PUT /proyectos/1.json
  def update
    parameters = proyecto_params
    products = parameters[:products]
    parameters.delete(:products)

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
                @proyecto.product_referenceables.find_by(product_id: product.id).destroy
            end
        end

        format.html { redirect_to @proyecto, notice: 'Artículo actualizdo exitosamente.' }
        format.json { render :show, status: :ok, location: @proyecto }
      else
        format.html { render :edit }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proyectos/1
  # DELETE /proyectos/1.json
  def destroy
    @proyecto.destroy
    respond_to do |format|
      format.html { redirect_to proyectos_url, notice: 'Artículo destruido exitosamente.' }
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
      params.require(:proyecto).permit(:title, :title2, :content, :content2, :description, :description2, {:products => []}, :image)
    end
end
