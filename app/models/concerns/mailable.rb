module Mailable
    def send_mail
        User.where(newsletter: true).find_each do |user|
            ArticlesMailer.article(user, self).deliver_later
        end
    end
end