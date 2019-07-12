class CreateCourseLocales < ActiveRecord::Migration[5.2]
  def change
    create_table :course_locales do |t|
      t.integer :course_id, null: false
      t.integer :locale_id, null: false
      t.timestamps
    end
  end
end
