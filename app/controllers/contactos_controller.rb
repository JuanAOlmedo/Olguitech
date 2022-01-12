class ContactosController < ApplicationController
    def index; end

    def new
        @contacto = Contacto.new
        @user = @contacto.user
    end

    def update; end

    def create
        unless @user =
                   User.find_by(user_params) && @user.name && @user.phone &&
                       @user.company
            parameters = user_params
            parameters[:locale] = I18n.locale

            @user = User.new(parameters)

            @contacto = @user.contactos.new(contacto_params)
            @contacto.preference = @contacto.preference.to_i
            @contacto.preference2 = @contacto.preference2.to_i

            if @user.save && @contacto.save
                session[:will_contact] = true
                redirect_to(
                    {
                        controller: 'users',
                        action: 'edit',
                        id: @user.id,
                        edit_token: @user.edit_token
                    },
                    notice: I18n.t("contact.first_time")
                )
            else
                render :new, status: :unprocessable_entity
            end
        else
            @contacto = @user.contactos.new(contacto_params)
            @contacto.preference = @contacto.preference.to_i
            @contacto.preference2 = @contacto.preference2.to_i

            if @contacto.save
                article = Article.find(@contacto.preference)
                proyecto = Proyecto.find(@contacto.preference2)

                article = article.get_title
                proyecto = proyecto.get_title

                @mail =
                    ContactMailer.contacto(
                        @user,
                        article,
                        proyecto,
                        @contacto.message
                    ).deliver_now!
                @mail =
                    ContactMailer.admin_contacto(
                        @user,
                        Article.find(@contacto.preference).title,
                        Proyecto.find(@contacto.preference2).title,
                        @contacto.message
                    ).deliver_now!
                redirect_to "/#{I18n.locale}/contacto",
                            notice: I18n.t('contact.sent')
            else
                render :new, status: :unprocessable_entity
            end
        end
    end

    private

    def contacto_params
        params.require(:contacto).permit :preference, :preference2, :message
    end

    def user_params
        params.require(:user).permit :email
    end
end
