require "rails_helper"

RSpec.describe EventsController, type: :controller do
  describe "GET events/non_overlapping_events" do
    let!(:available_event_1) { Event.create!(start_time: "2018-12-19 16:00:00", end_time: "2018-12-19 17:00:00", event_type: "available") }
    let!(:available_event_2) { Event.create!(start_time: "2018-12-20 9:30:00", end_time: "2018-12-20 11:30:00", event_type: "available") }
    let!(:available_event_3) { Event.create!(start_time: "2018-12-21 9:00:00", end_time: "2018-12-21 11:00:00", event_type: "available") }
    let!(:booked_event_1) { Event.create!(start_time: "2018-12-19 16:00:00", end_time: "2018-12-19 17:00:00", event_type: "booked") }
    let!(:booked_event_2) { Event.create!(start_time: "2018-12-20 9:00:00", end_time: "2018-12-20 10:00:00", event_type: "booked") }

    it "returns a list of non-overlapping available events as JSON" do
      get :non_overlapping_events


      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.size).to eq(1)
      expect(json_response.first["id"]).to eq(available_event_3.id)
      expect(json_response.first["start_time"].to_datetime).to eq("2018-12-21 9:00:0".to_datetime)
      expect(json_response.first["end_time"].to_datetime).to eq("2018-12-21 11:00:00".to_datetime)
      expect(json_response.first["event_type"]).to eq("available")
    end
  end
end
