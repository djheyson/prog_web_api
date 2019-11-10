class CreateArchives < ActiveRecord::Migration[6.0]
  def change
    create_table :archives do |t|
      t.string :title
      t.text :archive_data

      t.timestamps
    end
  end
end
