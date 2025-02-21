#frozen_string_literal: true

# Includes all the functionality of Products, Projects and SolutionsControllers.
module Articles
    extend ActiveSupport::Concern

    included do
        before_action :set_article, only: %i[show edit update destroy]
        before_action :authenticate_admin!, except: %i[index show]
    end

    def index
        @super_categories = SuperCategory.related_to model.model_name.plural
        @super_category = @super_categories.find do |sc|
            sc.id == params[:super_category_id].to_i
        end || @super_categories.first
    end

    def new
        @article = model.new
    end

    # Count the number of views of an article. Store in the user's session that
    # the article has been viewed
    def show
        session_name = :"viewed_#{model.model_name.plural}"
        session[session_name] = [] unless session[session_name]

        return if @article.id.in? session[session_name]

        @article.update views: @article.views + 1
        session[session_name] << @article.id
    end

    def create
        @article = model.new article_params

        respond_to do |format|
            if @article.save
                format.html { redirect_to @article, notice: 'Artículo creado exitosamente.' }
                format.json { render :show, status: :created, location: @article }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end

    def edit; end

    def update
        respond_to do |format|
            if @article.update article_params
                format.html do
                    redirect_to @article, notice: 'Artículo actualizado exitosamente.'
                end
                format.json { render :show, status: :ok, location: @article }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @article.destroy

        respond_to do |format|
            format.html do
                redirect_to send("#{model.model_name.plural}_url"),
                            notice: 'Artículo destruido exitosamente.',
                            status: :see_other
            end
            format.json { head :no_content }
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
