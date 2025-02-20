class RenameArticlesToSolutions < ActiveRecord::Migration[8.0]
  def change
      rename_table :articles, :solutions
  end
end
