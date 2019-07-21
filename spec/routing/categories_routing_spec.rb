require "rails_helper"

RSpec.describe CategoriesController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "/categories/1").to route_to(action: "show", controller: "categories", id: "1" )
    end

    it "no routes for /categories" do
      expect(get: "/categories").not_to be_routable
    end
  end
end
