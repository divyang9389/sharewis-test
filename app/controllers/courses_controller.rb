class CoursesController < ApplicationController
  def index
    courses = Course

    locale_code = params[:locale_code].in?(%w(en ja vi)) || default_locale_code
    locale = Locale.find_by(code: locale_code)
    courses = Course.joins(:course_locales).where('course_locales.locale_id = ?', locale&.id)

    unless params[:include_unpublished_courses].present? && to_boolean(params[:include_unpublished_courses])
      courses = courses.where(published: true)
    end

    if params[:exclude_disabled_courses].present? && to_boolean(params[:exclude_disabled_courses])
      courses = courses.where(disabled: false)
    end

    if params[:type].present? && params[:type].in?(%w(pro_courses snack_courses))
      type = params[:type] == 'pro_courses' ? 'ProCourse' : 'SnackCourse'
      courses = courses.where(type: type)
    end

    if params[:paid_courses_only].present? && to_boolean(params[:paid_courses_only])
      courses = courses.where("price > 0 AND type <> 'SnackCourse'")
    elsif params[:free_courses_only].present? && to_boolean(params[:free_courses_only])
      courses = courses.where("price = ? OR type = 'SnackCourse'", 0)
    end

    if params[:instructor_id].present?
      courses = courses.where(instructor_id: params[:instructor_id])
    end

    if params[:category_id].present?
      courses = courses.where(category_id: params[:category_id])
    elsif params[:category_slug].present?
      courses = courses.joins(:category).where('categories.slug = ?', params[:category_slug])
    end

    if params[:tag_ids].present?
      courses = courses.joins(:tags).where('tags.id IN (?)', params[:tag_ids])
    elsif params[:tag_slugs].present?
      courses = courses.joins(:tags).where('tags.slug IN (?)', params[:tag_slugs])
    end

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
