class CategoriesController < ApplicationController
  def show
    category = Category.find(params[:id])
    param_data = permitted_params
    # This will set locale
    locale_code = params[:locale_code].in?(%w(en ja vi)) ? params[:locale_code] : default_locale_code
    locale = Locale.find_by(code: locale_code)
    # Find courses base on locale & cagegory.
    courses = locale.courses.where(published: true).where(disabled: false).where(category_id: category.id)

    # service will filter course base on extra filter which given in params.
    courses = CourseSearchService::CourseSearchService.new(courses: courses, params_data: param_data).search

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

  private

  def permitted_params
    params.permit(:id,
      :locale_code,
      :include_unpublished_courses,
      :exclude_disabled_courses,
      :paid_courses_only,
      :free_courses_only,
      :instructor_id,
      :category_slug,
      :tag_ids,
      :tag_slugs,
      :q)
  end
end
