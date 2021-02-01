class FixConfirmForAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :unconfirmed_email, :string
  end
end
