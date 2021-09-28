class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.integer :duration_in_days
      t.integer :nbr_of_person_required
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end
