require 'rails_helper'

RSpec.describe "Punchcards", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/punchcards/index"
      expect(response).to have_http_status(:success)
    end
  end

end
