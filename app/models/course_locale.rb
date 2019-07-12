class CourseLocale < ApplicationRecord
  belongs_to :locale
  belongs_to :course
end
