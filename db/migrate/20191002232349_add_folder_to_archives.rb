class AddFolderToArchives < ActiveRecord::Migration[6.0]
  def change
    add_reference :archives, :folder, foreign_key: true
  end
end
