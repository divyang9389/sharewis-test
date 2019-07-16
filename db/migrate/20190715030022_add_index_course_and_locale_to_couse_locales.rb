class AddIndexCourseAndLocaleToCouseLocales < ActiveRecord::Migration[5.2]
  def change
    add_index :course_locales, :course_id
    add_index :course_locales, :locale_id
  end
end
