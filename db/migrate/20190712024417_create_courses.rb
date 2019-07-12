class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string  :title, null: false
      t.string  :type, null: false
      t.boolean :published, null: false, default: false
      t.boolean :disabled, null: false, default: false
      t.decimal :price, precision: 13, scale: 4, null: false, default: 0.0
      t.integer :instructor_id, null: false
      t.integer :category_id, null: false
      t.timestamps
    end
  end
end
