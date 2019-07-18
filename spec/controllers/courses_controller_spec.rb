require 'rails_helper'

RSpec.describe CoursesController, type: :controller do

#   let(:valid_attributes) {
#     skip("Add a hash of attributes valid for your model")
#   }

#   let(:invalid_attributes) {
#     skip("Add a hash of attributes invalid for your model")
#   }

  let(:valid_session) { {} }
  let!(:locale) { create(:locale, name: 'English', code: 'en')}
  let!(:category)  { create(:category, name: 'Devoops', slug: 'devoops' ) }
  let!(:category1) { create(:category, name: 'Networking', slug: 'networking' ) }
  let!(:instructor)  { create(:instructor, name: 'Dev' ) }
  let!(:instructor1) { create(:instructor, name: 'Alis' ) }
  let!(:instructor2) { create(:instructor, name: 'John' ) }
  let!(:instructor3) { create(:instructor, name: 'Jane' ) }
  let!(:courses1) { create(:course, title: "Aws Doops", type: "ProCourse", price: 1000.0, instructor_id: instructor.id, category_id: category.id)}
  let!(:courses1_1) { create(:course, title: "ProAws Doops", type: "ProCourse", price: 1000.0, instructor_id: instructor.id, category_id: category.id)}
  let!(:courses2) { create(:course, title: "Master in Networking", type: "SnackCourse", price: 0, instructor_id: instructor1.id, category_id: category1.id)}
  let!(:courses2_2) { create(:course, title: "Pro in Networking", type: "SnackCourse", price: 99.0, instructor_id: instructor1.id, category_id: category1.id)}

  let!(:tag1) { create(:tag, name: "Ruby", slug: "ruby")}
  let!(:lcourse1) { create(:course_locale, course_id: courses1.id, locale_id: locale.id)}
  let!(:lcourse2) { create(:course_locale, course_id: courses2.id, locale_id: locale.id)}

  describe "GET #index" do

    it "only published course will be return as json" do
      courses1.update(published: true)
      get :index, params: {}, session: valid_session
      response_body = JSON.parse(response.body)
      data = response_body["data"]
      courses = data["courses"]
      expect(response).to be_successful
      expect(courses.length).to eq(1)
    end

    it "Courses will be filtered by type" do
      courses1.update(published: true)
      courses2.update(published: true)
      get :index, params: {type: 'ProCourse'}, session: valid_session
      response_body = JSON.parse(response.body)
      data = response_body["data"]
      courses = data["courses"]
      expect(response).to be_successful
      expect(courses.length).to eq(2)
    end

    it "Free course will be filtered" do
      courses1.update(published: true)
      courses2.update(published: true)
      get :index, params: {free_courses_only: 'yes'}, session: valid_session
      response_body = JSON.parse(response.body)
      data = response_body["data"]
      courses = data["courses"]
      expect(response).to be_successful
      expect(courses.length).to eq(1)
    end

    it "will be filtered course base on query params 'Aws' " do
      courses1.update(published: true)
      courses2.update(published: true)
      get :index, params: {q: 'Aws'}, session: valid_session
      response_body = JSON.parse(response.body)
      data = response_body["data"]
      courses = data["courses"]
      expect(response).to be_successful
      expect(courses.length).to eq(1)
    end

  end

end
