class CreateBuyerAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :buyer_addresses do |t|

      t.timestamps
      t.string :postnumber, null:false
      t.string :telephonenumber, null:false
      t.integer :area_id, null:false
      t.string :area_town, null:false
      t.string :area_street, null:false
      t.string :building_name
      t.references :buyer, null:false, foreign_key: true
    end
  end
end
