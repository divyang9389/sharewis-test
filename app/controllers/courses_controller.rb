class CoursesController < ApplicationController
  def index
    # courses = Course

    locale_code = params[:locale_code].in?(%w(en ja vi)) ? params[:locale_code] : default_locale_code
    locale = Locale.find_by(code: locale_code)
    courses = locale.courses.joins(:course_locales).where('course_locales.locale_id = ?', locale&.id)

    courses = CourseSearchService::CourseSearchService.new(courses: courses, params_data: params).search

    courses = courses.distinct

    courses = courses.page(params[:page] || 1).per(10)

    render json: {
      data: { courses: courses }
    }
  end

  private

  def permitted_params
    params.permit(:locale_code,
      :include_unpublished_courses,
      :exclude_disabled_courses,
      :paid_courses_only,
      :free_courses_only,
      :instructor_id,
      :category_id,
      :category_slug,
      :tag_ids,
      :tag_slugs,
      :page)
  end
end
