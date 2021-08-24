class CreateAvatars < ActiveRecord::Migration[6.1]
  def change
    create_table :avatars do |t|
      t.references :user, null: false, foreign_key: true
      t.string :url, null: false
      t.string :public_id, null: false
      t.timestamps
    end
  end
end
