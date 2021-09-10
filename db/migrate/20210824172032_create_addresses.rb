class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.references :addressable, polymorphic: true
      t.string :formatted_address
      t.string :house_number
      t.string :street
      t.string :post_code
      t.string :state
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
