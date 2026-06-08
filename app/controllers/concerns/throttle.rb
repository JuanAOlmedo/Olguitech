# frozen_string_literal: true

# Cuenta la cantidad de contactos y decide si es necesario bloquear una request.
# Requiere Rails.cache, por lo que tiene que estar configurado
module Throttle
    # Bloquea si hay más de cinco contactos en un día
    MAX_CONTACTS = 5
    TIME_WINDOW = 1.day

    def contact_count
        Rails.cache.write key, 0, raw: true, expires_in: TIME_WINDOW, unless_exist: true
        Rails.cache.read(key, raw: true).to_i
    end

    def increment_contact_count
        Rails.cache.write key, 0, raw: true, expires_in: TIME_WINDOW, unless_exist: true
        Rails.cache.increment key
    end

    def block_contact?
        contact_count >= MAX_CONTACTS
    end

    private

    def key
        "contactos_#{Time.now.to_i / TIME_WINDOW.to_i}"
    end
end
