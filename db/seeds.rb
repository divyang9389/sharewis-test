ja = Locale.find_or_create_by(code: :ja, name: 'Japanese')

en = Locale.find_or_create_by(code: :en, name: 'English')

vi = Locale.find_or_create_by(code: :vi, name: 'Vietnamese')

programming = Category.find_or_create_by(name: 'Programming', slug: 'programming')

ruby = Tag.find_or_create_by(name: 'Ruby', slug: 'ruby')

instructor_jordan = Instructor.find_or_create_by(name: 'Jordan Hudgens')

course = Course.find_or_create_by(
  type: 'ProCourse',
  title: 'Comprehensive Ruby 2.x Programming',
  category_id: programming.id,
  published: false,
  price: 10000.0,
  instructor_id: instructor_jordan.id
)

CourseLocale.find_or_create_by(course_id: course.id, locale_id: en.id)

CourseLocale.find_or_create_by(course_id: course.id, locale_id: ja.id)
course.update(published: true)
CourseTag.create(course_id: course.id, tag_id: ruby.id)


course = Course.find_or_create_by(
  type: 'ProCourse',
  title: 'Comprehensive Ruby 1.x Programming',
  category_id: programming.id,
  published: false,
  disabled: true,
  price: 8000.0,
  instructor_id: instructor_jordan.id
)

CourseLocale.find_or_create_by(course_id: course.id, locale_id: en.id)

CourseLocale.find_or_create_by(course_id: course.id, locale_id: ja.id)
course.update(published: true)
CourseTag.create(course_id: course.id, tag_id: ruby.id)
