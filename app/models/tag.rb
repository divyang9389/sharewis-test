class Tag < ApplicationRecord
  has_many :course_tags, dependent: :destroy
end
