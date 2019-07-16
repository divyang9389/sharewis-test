class Locale < ApplicationRecord
  has_many :course_locales, dependent: :destroy
  has_many :courses, through: :course_locales
end
