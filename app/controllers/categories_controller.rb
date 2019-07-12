class CategoriesController < ApplicationController
  def show
    category = Category.find(params[:id])

    locale_code = params[:locale_code].in?(%w(en ja vi)) || default_locale_code
    locale = Locale.find_by(code: locale_code)
    courses = Course.joins(:course_locales).where('course_locales.locale_id = ?', locale&.id)

    courses = courses.where(published: true).where(disabled: false).where(category_id: category.id)

    if params[:paid_courses_only].present? && to_boolean(params[:paid_courses_only])
      courses = courses.where("price > 0 AND type <> 'SnackCourse'")
    elsif params[:free_courses_only].present? && to_boolean(params[:free_courses_only])
      courses = courses.where("price = ? OR type = 'SnackCourse'", 0)
    end

    if params[:type].present? && params[:type].in?(%w(pro_courses snack_courses))
      type = params[:type] == 'pro_courses' ? 'ProCourse' : 'SnackCourse'
      courses = courses.where(type: type)
    end

    if params[:instructor_id].present?
      courses = courses.where(instructor_id: params[:instructor_id])
    end

    if params[:tag_ids].present?
      courses = courses.joins(:tags).where('tags.id IN (?)', params[:tag_ids])
    elsif params[:tag_slugs].present?
      courses = courses.joins(:tags).where('tags.slug IN (?)', params[:tag_slugs])
    end

    courses = courses.distinct

    render json: {
      data: {
        category: {
          name: category.name,
          slug: category.slug,
          courses: courses
        }
      }
    }
  end
end
