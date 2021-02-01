admin = Admin.new
admin.name = ENV["ADMIN_NAME"]
admin.password = ENV["ADMIN_PASSWORD"]
admin.email = ENV["ADMIN_EMAIL"]
admin.save!