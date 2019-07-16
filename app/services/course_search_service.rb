module CourseSearchService
  class CourseSearchService
    def initialize(courses: nil, params_data: {})
      @courses = courses
      @params_data = params_data
    end


    def search
      unless @params_data[:include_unpublished_courses].present? && to_boolean(@params_data[:include_unpublished_courses])
        @courses = @courses.where(published: true)
      end

      if @params_data[:exclude_disabled_courses].present? && to_boolean(@params_data[:exclude_disabled_courses])
        @courses = @courses.where(disabled: false)
      end

      if @params_data[:type].present? && @params_data[:type].in?(%w(pro_courses snack_courses))
        type = @params_data[:type] == 'pro_courses' ? 'ProCourse' : 'SnackCourse'
        @courses = @courses.where(type: type)
      end

      if @params_data[:paid_courses_only].present? && to_boolean(@params_data[:paid_courses_only])
        @courses = @courses.where("price > 0 AND type <> 'SnackCourse'")
      elsif @params_data[:free_courses_only].present? && to_boolean(@params_data[:free_courses_only])
        @courses = @courses.where("price = ? OR type = 'SnackCourse'", 0)
      end

      if @params_data[:instructor_id].present?
        @courses = @courses.where(instructor_id: @params_data[:instructor_id])
      end

      if @params_data[:category_id].present?
        @courses = @courses.where(category_id: @params_data[:category_id])
      elsif @params_data[:category_slug].present?
        @courses = @courses.joins(:category).where('categories.slug = ?', @params_data[:category_slug])
      end

      if @params_data[:paid_courses_only].present? && to_boolean(@params_data[:paid_courses_only])
        @courses = @courses.where("price > 0 AND type <> 'SnackCourse'")
      elsif @params_data[:free_courses_only].present? && to_boolean(@params_data[:free_courses_only])
        @courses = @courses.where("price = ? OR type = 'SnackCourse'", 0)
      end

      if @params_data[:type].present? && @params_data[:type].in?(%w(pro_courses snack_courses))
        type = @params_data[:type] == 'pro_courses' ? 'ProCourse' : 'SnackCourse'
        @courses = @courses.where(type: type)
      end

      if @params_data[:instructor_id].present?
        @courses = @courses.where(instructor_id: @params_data[:instructor_id])
      end

      if @params_data[:tag_ids].present?
        @courses = @courses.joins(:tags).where('tags.id IN (?)', @params_data[:tag_ids])
      elsif @params_data[:tag_slugs].present?
        @courses = @courses.joins(:tags).where('tags.slug IN (?)', @params_data[:tag_slugs])
      end

      if @params_data[:q].present?
        @courses = @courses.filter_data(@params_data[:q])
      end

      return @courses
    end
  end
end