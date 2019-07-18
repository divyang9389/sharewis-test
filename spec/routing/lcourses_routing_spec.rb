require "rails_helper"

RSpec.describe CoursesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/courses").to route_to("courses#index")
    end

  end
end
