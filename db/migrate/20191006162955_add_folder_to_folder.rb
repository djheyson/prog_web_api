class AddFolderToFolder < ActiveRecord::Migration[6.0]
  def change
    add_reference :folders, :folder, null: true, foreign_key: true
  end
end
