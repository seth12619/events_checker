class EventsController < ApplicationController
  def non_overlapping_events
    @non_overlapping_events = Event.non_overlapping_available
    render json: @non_overlapping_events
  end
end
