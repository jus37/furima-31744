class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|

      t.timestamps
      t.string :name, null: false
      t.text :content, null: false
      t.integer :category_id, null: false
      t.integer :status_id, null: false
      t.integer :cost_id, null: false
      t.integer :area_id, null: false
      t.integer :date_id, null: false
      t.integer :price_id, null: false
      t.references :user, null: false, foreign_keys: true
    end
  end
end
