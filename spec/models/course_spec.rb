require 'rails_helper'

RSpec.describe Course, type: :model do
  let!(:locale) { create(:locale, name: 'English', code: 'en')}
  let!(:category) { create(:category, name: 'category', slug: 'category' ) }
  let!(:category1) { create(:category, name: 'category1', slug: 'category1' ) }
  let!(:instructor) { create(:instructor, name: 'instructor1' ) }

  describe "Associations" do
    it { should belong_to(:category) }
    it { should belong_to(:instructor) }
    it { should have_many(:course_locales) }
    it { should have_many(:course_tags).dependent(:destroy)}
    it { should have_many(:tags).through(:course_tags) }
  end

  describe "Validations" do
    it { should allow_values('ProCourse' ,'SnackCourse').for(:type)}
    it { should_not allow_values('Test').for(:type)}
    it { should validate_presence_of(:title)}
  end

  describe "Course will be create" do
    
    it "Should have valid data so course will create" do 
      course = Course.create(category_id: category.id, title: 'test course', type: 'ProCourse', price: 100.0,instructor_id: instructor.id )
      expect(course.type).to eq('ProCourse')
      expect(course.category).to eq(category)
    end

    it "Should not published without course_locale" do
      course = Course.new(category_id: category.id, title: 'test course', type: 'ProCourse', published: true, price: 100.0,instructor_id: instructor.id )
      course.valid?
      expect(course.errors[:published]).to eq(['you have to set locale to publish.'])
    end

    it "Should published " do 
      course = Course.create(category_id: category.id, title: 'test course', type: 'ProCourse', price: 100.0,instructor_id: instructor.id )
      course.course_locales.create(locale_id: locale.id)
      course.update(published: true)
      expect(course.published).to eq(true)
    end
  end
end