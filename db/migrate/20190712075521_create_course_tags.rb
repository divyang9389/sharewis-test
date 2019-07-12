class CreateCourseTags < ActiveRecord::Migration[5.2]
  def change
    create_table :course_tags do |t|
      t.integer :course_id, null: false
      t.integer :tag_id, null: false
      t.timestamps
    end
  end
end
