require 'rails_helper'

RSpec.describe "Courses", type: :request do

  let!(:locale) { create(:locale, name: 'English', code: 'en')}

  describe "GET /courses" do
    before do
      get courses_path
    end

    it "response should be in JSON" do
      expect(response).to have_http_status(200)
    end

    it "JSON body has data key"do
      json_body = JSON.parse(response.body)
      expect(json_body.keys).to match_array(["data"])
    end
  end
end
