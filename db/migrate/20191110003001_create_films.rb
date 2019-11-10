class CreateFilms < ActiveRecord::Migration[6.0]
  def change
    create_table :films do |t|
      t.string :title
      t.integer :time
      t.string :thumbnail
      t.integer :year
      t.references :format, null: false, foreign_key: true

      t.timestamps
    end
  end
end
