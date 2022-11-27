# frozen_string_literal: true

class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update destroy]
    before_action :authenticate_edit_token, only: %i[edit destroy update]
    before_action :authenticate_admin!,
                  :redirect_unless_admin,
                  only: %i[index new create]

    def index
        @users = User.all.order id: :asc
        @contacted = User.where.associated(:contactos).uniq
    end

    def show; end

    def new
        @user = User.new
    end

    def edit; end

    def destroy
        @user.destroy

        respond_to do |format|
            format.html do
                redirect_to root_path,
                            notice: I18n.t('users.deleted'),
                            status: :see_other
            end
            format.json { head :no_content }
        end
    end

    def create
        @user = User.new user_params.except(:auto_confirm)
        @user.confirm if user_params[:auto_confirm] == '1'

        if @user.save
            respond_to do |format|
                format.html { redirect_to root_path }
                format.turbo_stream
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params.merge!(locale: I18n.locale))
            redirect_to root_path, notice: t(params[:contact] ? 'contact.sent' : 'user_edited')
        else
            render :edit, status: :unprocessable_entity
        end
    end

    # Confirm user if they provide a valid confirmation_token
    def confirmation
        @user = User.find_by confirmation_token: params[:confirmation_token]

        if @user&.confirm
            redirect_to root_path, notice: t('confirmed')
        else
            redirect_to root_path, alert: t('link_borken')
        end
    end

    # Find or create an user based on their email, subscribe them to newsletters
    # and update their locale
    def subscribe
        @user = User.find_by(user_params) || User.new(user_params)

        @user.newsletter = true
        @user.locale = I18n.locale

        if @user.save
            redirect_to root_path, notice: t('thanks_for_subscribing')
        else
            redirect_to root_path, alert: t('valid_email'),
                                   status: :unprocessable_entity
        end
    end

    # Unsubscribe the user to newsletters with the provided newsletter_token
    def unsubscribe
        @user = User.find_by newsletter_token: params[:newsletter_token]

        if @user&.update(newsletter: false)
            redirect_to root_path, notice: t('unsubscribed')
        else
            redirect_to root_path, alert: t('link_broken')
        end
    end

    private

    def redirect_unless_admin
        return if admin_signed_in?

        redirect_to root_path,
                    status: :unauthorized,
                    alert: t('not_allowed')
    end

    def set_user
        @user = User.friendly.find(params[:id])
    end

    # Check that an edit_token has been provided in the params or in the
    # form to authenticate the user
    def authenticate_edit_token
        @user.regenerate_edit_token unless @user.edit_token

        return if [params[:edit_token], params.dig(:users, :edit_token)].include? @user.edit_token

        redirect_to root_path, alert: t('not_allowed')
    end

    def user_params
        params.require(:user).permit :email,
                                     :name,
                                     :phone,
                                     :company,
                                     :newsletter,
                                     :locale,
                                     :edit_token,
                                     :auto_confirm
    end
end
