class CreateCommunities < ActiveRecord::Migration[6.1]
  def change
    create_table :communities do |t|
      t.string :name
      t.text :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
