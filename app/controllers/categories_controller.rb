class CategoriesController < ApplicationController
  def show
    category = Category.find(params[:id])
    # This will set locale
    locale_code = params[:locale_code].in?(%w(en ja vi)) ? params[:locale_code] : default_locale_code
    locale = Locale.find_by(code: locale_code)
    # Find courses base on locale & cagegory.
    courses = locale.courses.where(published: true).where(disabled: false).where(category_id: category.id)

    # service will filter course base on extra filter which given in params.
    courses = CourseSearchService::CourseSearchService.new(courses: courses, params_data: params).search

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
