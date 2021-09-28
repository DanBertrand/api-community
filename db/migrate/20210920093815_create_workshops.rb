class CreateWorkshops < ActiveRecord::Migration[6.1]
  def change
    create_table :workshops do |t|
      t.string :title
      t.text :description
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
