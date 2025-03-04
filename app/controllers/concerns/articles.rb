#frozen_string_literal: true

# Includes all the functionality of Products, Projects and SolutionsControllers.
# Defines the model corresponding to the controller in @model
module Articles
    extend ActiveSupport::Concern

    included do
        before_action :set_article, only: %i[show edit update destroy change_status]
        before_action :authenticate_admin!, except: %i[index show]
    end

    # If the uncategorized param is present, show only uncategorized articles
    # GET /solutions
    #     /products
    #     /projects
    def index
        @uncategorized = params[:uncategorized].present?
        @articles = if @uncategorized
                        model.published.uncategorized.select model.fields_for_cards
                    else
                        model.published.select model.fields_for_cards
                    end
    end

    # GET /solutions/new
    #     /products/new
    #     /projects/new
    def new
        @article = model.new
    end

    # Count the number of views of an article. Store in the user's session that
    # the article has been viewed
    # GET /solutions/1
    #     /products/1
    #     /projects/1
    def show
        session_name = :"viewed_#{model.model_name.plural}"
        session[session_name] = [] unless session[session_name]

        return if @article.id.in? session[session_name]

        @article.update views: @article.views + 1
        session[session_name] << @article.id
    end

    # POST /solutions
    #      /products
    #      /projects
    def create
        @article = model.new article_params

        if @article.save
            redirect_to @article, notice: 'Artículo creado exitosamente.'
        else
            render :new, status: :unprocessable_entity
        end
    end

    # GET /solutions/1/edit
    #     /products/1/edit
    #     /projects/1/edit
    def edit; end

    # JSON requests are made from the dashboard to update an article
    # PATCH /solutions/1
    #       /products/1
    #       /projects/1
    def update
        if @article.update article_params
            respond_to do |format|
                format.html { redirect_to @article, notice: 'Artículo actualizado exitosamente.' }
                format.json { head :ok }
            end
        else
            respond_to do |format|
                format.html { redirect_to @article, notice: 'Artículo actualizado exitosamente.' }
                format.json { head :unprocessable_entity }
            end
        end
    end

    # DELETE /solutions/1
    #        /products/1
    #        /projects/1
    def destroy
        @article.destroy

        respond_to do |format|
            format.html do
                redirect_to send("#{model.model_name.plural}_url"),
                            notice: 'Artículo destruido exitosamente.',
                            status: :see_other
            end
            format.json { head :see_other }
        end
    end

    private

    # Set the model used in the controller.
    # For example, if the controller is SolutionsController, the model will be Solution.
    def model
        @model ||= self.class.name.sub('Controller', '').singularize.constantize
    end

    def set_article
        @article = model.friendly.find(params[:id])

        authenticate_admin! unless @article.published?
    end
end
