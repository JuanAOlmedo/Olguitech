class AddLockToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :failed_attempts, :integer, default: 0, null: false # Only if lock strategy is :failed_attempts
    add_column :admins, :unlock_token, :string # Only if unlock strategy is :email or :both
    add_column :admins, :locked_at, :datetime

    add_index :admins, :unlock_token, unique: true
  end
end
