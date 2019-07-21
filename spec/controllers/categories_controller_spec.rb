require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

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


  describe "GET #show" do

    it "should have successful response" do
      get :show, params:{id: category.id}
      expect(response).to be_successful
    end

    it "category course will be return" do
      courses1.update(published: true)
      courses2.update(published: true)
      get :show, params:{id: category.id}
      response_body = JSON.parse(response.body)
      data = response_body["data"]
      courses = data["category"]["courses"]
      expect(response).to be_successful
      expect(courses.length).to eq(1)
    end


    it "should not filter data base on params category_id" do
      courses1.update(published: true)
      courses2.update(published: true)
      get :show, params:{id: category.id, category_id: category1.id}
      response_body = JSON.parse(response.body)
      data = response_body["data"]
      courses = data["category"]["courses"]
      expect(response).to be_successful
      expect(courses.length).to eq(1)
    end
  end
end