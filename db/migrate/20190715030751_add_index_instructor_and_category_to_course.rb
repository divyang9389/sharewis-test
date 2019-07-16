class AddIndexInstructorAndCategoryToCourse < ActiveRecord::Migration[5.2]
  def change
    add_index :courses, :instructor_id
    add_index :courses, :category_id
  end
end
