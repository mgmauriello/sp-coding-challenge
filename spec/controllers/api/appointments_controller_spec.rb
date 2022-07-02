RSpec.describe Api::AppointmentsController do

  describe "#index" do
    it "returns json data" do
      get :index
      expect(response.status).to eq(200)
    end
  end

  # describe "API appointments", type: :request do
  #   describe "POST /api/appointments" do
  #     it 'create new appointment' do
  #       expect{
  #         post '/api/appointments', params: {
  #           "patient": {
  #             "name": FactoryBot.create(:patient)
  #           },
  #           "doctor": {
  #             "id": FactoryBot.create(:doctor).id
  #           },
  #           "start_time": "2023-10-22T00:00:00.000Z",
  #           "duration_in_minutes": 50
  #         }
  #       }.to change {Appointment.count}.from(0).to(1)
  #       expect(response).to have_http_status(:created)
  #     end
  #   end
  # end

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
