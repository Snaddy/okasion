class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :cover_image
      t.string :category
      t.integer :user_id
      t.date :date
      t.time :time
      t.time :endtime
      t.string :url

      t.timestamps null: false
    end
  end
end
