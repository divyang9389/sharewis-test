class Course < ApplicationRecord
  self.inheritance_column = nil

  belongs_to :category
  belongs_to :instructor
  has_many :course_locales, dependent: :destroy
  has_many :course_tags, dependent: :destroy
  has_many :tags, through: :course_tags

  validates :type, inclusion: { in: %w(ProCourse SnackCourse) }
  validates :title, presence: true
  validate :require_locale

  scope :filter_data, ->(search_keyword) { left_joins(:instructor, :category, :tags).where("courses.id = '#{search_keyword}' OR courses.title LIKE '%#{search_keyword}%' OR categories.name LIKE '%#{search_keyword}%' OR tags.name LIKE '#{search_keyword}' OR instructors.name LIKE '%#{search_keyword}%'") }
  

  def require_locale
    if self.published
      unless self.course_locales.present?
        errors.add(:published, "you have to set locale to publish.")
      end
    end
  end
end
