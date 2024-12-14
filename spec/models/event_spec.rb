require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:available_event_1) { Event.create!(start_time: "2018-12-19 16:00:00", end_time: "2018-12-19 17:00:00", event_type: "available") }
  let!(:available_event_2) { Event.create!(start_time: "2018-12-20 9:30:00", end_time: "2018-12-20 11:30:00", event_type: "available") }
  let!(:available_event_3) { Event.create!(start_time: "2018-12-21 9:00:00", end_time: "2018-12-21 11:00:00", event_type: "available") }
  let!(:booked_event_1) { Event.create!(start_time: "2018-12-19 16:00:00", end_time: "2018-12-19 17:00:00", event_type: "booked") }
  let!(:booked_event_2) { Event.create!(start_time: "2018-12-20 9:00:00", end_time: "2018-12-20 10:00:00", event_type: "booked") }

  describe 'self.non_overlapping_available' do
    it 'returns only non-overlapping available events' do
      result = Event.non_overlapping_available
      expect(result).to contain_exactly(available_event_3)
    end

    it 'does not include overlapping events' do
      result = Event.non_overlapping_available
      expect(result).not_to include(available_event_1, available_event_2)
    end
  end

  describe 'self.overlap?' do
    it 'returns true for overlapping events' do
      expect(Event.overlap?(available: available_event_1, booked: booked_event_1)).to be true
    end

    it 'returns false for non-overlapping events' do
      expect(Event.overlap?(available: available_event_3, booked: available_event_1)).to be false
    end
  end

  describe 'self.day_of_week_overlap' do
    let(:available_event_mon_wed) { Event.new(start_time: "2024-12-09 10:00", end_time: "2024-12-11 12:00", event_type: "available") } # Monday to Wednesday
    let(:booked_event_tue_thurs) { Event.new(start_time: "2024-12-10 10:00", end_time: "2024-12-12 12:00", event_type: "booked") } # Tuesday to Thursday
    let(:booked_event_thurs_sat) { Event.new(start_time: "2024-12-12 12:00", end_time: "2024-12-14 14:00", event_type: "booked") } # Tuesday to Thursday

    it 'returns true for overlapping days of the week' do
      expect(Event.day_of_week_overlap(available: available_event_mon_wed, booked: booked_event_tue_thurs)).to be true
    end

    it 'returns false for non-overlapping days of the week' do
      expect(Event.day_of_week_overlap(available: available_event_mon_wed, booked: booked_event_thurs_sat)).to be false
    end
  end

  describe 'self.time_overlap' do
    let(:available_event_time_overlap) { Event.new(start_time: "2024-12-10 10:00", end_time: "2024-12-10 12:00", event_type: "available") }
    let(:booked_event_time_overlap) { Event.new(start_time: "2024-12-13 11:00", end_time: "2024-12-15 13:00", event_type: "booked") }
    let(:booked_event_time_overlap_2) { Event.new(start_time: "2024-12-13 12:01", end_time: "2024-12-15 14:00", event_type: "booked") }

    it 'returns true for overlapping times' do
      expect(Event.time_overlap(available: available_event_time_overlap, booked: booked_event_time_overlap)).to be true
    end

    it 'returns false for non-overlapping times' do
      expect(Event.time_overlap(available: available_event_time_overlap, booked: booked_event_time_overlap_2)).to be false
    end
  end

  describe 'start_day_of_the_week and end_day_of_the_week' do
    it 'returns the correct start day of the week' do
      expect(available_event_1.start_day_of_the_week).to eq(3) # Wed
    end

    it 'returns the correct end day of the week' do
      expect(available_event_2.end_day_of_the_week).to eq(4) # Thurs
    end
  end
end
