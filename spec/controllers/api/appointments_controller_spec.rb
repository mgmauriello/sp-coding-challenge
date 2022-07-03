RSpec.describe Api::AppointmentsController do

  describe "#index" do
    it "returns json data" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "GET /api/appointments", type: :request do
    before do
      5.times do
        FactoryBot.create(:appointment)
      end
    end

    it "returns all appointments" do
      get "/api/appointments"
      expect(response).to have_http_status(:success)
      # check to ensure correct number of results return
      expect(JSON.parse(response.body).length).to eq(5)
    end
  end

end
