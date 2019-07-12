class Locale < ApplicationRecord
  has_many :course_locales, dependent: :destroy
end
