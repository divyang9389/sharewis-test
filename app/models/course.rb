class Course < ApplicationRecord
  self.inheritance_column = nil

  has_many :course_locales, dependent: :destroy
  belongs_to :category

  has_many :course_tags, dependent: :destroy
  has_many :tags, through: :course_tags

  validates :type, inclusion: { in: %w(ProCourse SnackCourse) }
end
