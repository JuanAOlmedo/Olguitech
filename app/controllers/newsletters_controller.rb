class NewslettersController < ApplicationController
    before_action :set_newsletter, only: %i[show edit update destroy]
    before_action :authenticate_admin!, except: :show

    def index
        @newsletters = Newsletter.all.order(created_at: :desc)
    end

    # GET /newsletters/1
    def show; end

    # GET /newsletters/new
    def new
        @newsletter = Newsletter.new
    end

    # GET /newsletters/1/edit
    def edit; end

    # POST /newsletters
    # POST /newsletters.json
    def create
        @newsletter = Newsletter.new(newsletter_params)

        if @newsletter.save
            @users = User.all.where newsletter: true

            @users.each do |user|
                @mail =
                    NewsMailer.newsletter(
                        user,
                        @newsletter
                    ).deliver_now!
            end

            redirect_to root_path, notice: 'Se ha enviado la Newsletter'
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_newsletter
        @newsletter = Newsletter.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def newsletter_params
        params.require(:newsletter).permit(:title, :content, :subject)
    end

    def redirect_unless_admin
        if !admin_signed_in?
            flash[:alert] = 'Solo administradores pueden hacer eso'
            redirect_to root_path
        end
    end
end
