class CreateApplies < ActiveRecord::Migration[6.1]
  def change
    create_table :applies do |t|
      t.boolean :validated, default: false
      t.boolean :reviewed, default: false
      t.references :user, null: false, foreign_key: true

      t.references :job, null: true
      t.references :workshop, null: true
      t.timestamps
    end
  end
end
