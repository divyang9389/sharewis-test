class AddIndexCourseAndTagToCouseTags < ActiveRecord::Migration[5.2]
  def change
    add_index :course_tags, :course_id
    add_index :course_tags, :tag_id
  end
end
