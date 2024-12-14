class Event < ApplicationRecord
  def self.non_overlapping_available
    available_events = Event.where(event_type: "available")
    booked_events = Event.where(event_type: "booked")


    available_events = available_events.reject do |available|
      booked_events.any? do |booked|
        overlap?(available: available, booked: booked)
      end
    end

    available_events
  end

  def self.overlap?(available:, booked:)
    day_of_week_overlap(available: available, booked: booked) &&
    time_overlap(available: available, booked: booked)
  end

  def self.day_of_week_overlap(available:, booked:)
    # checks if wday is overlap: 0 - sunday, 6 - saturday
    if booked.start_day_of_the_week == 6
      return true if available.start_day_of_the_week <= booked.end_day_of_the_week || available.end_day_of_the_week <= booked.end_day_of_the_week
    end

    if booked.end_day_of_the_week == 6
      return true if available.start_day_of_the_week >= booked.start_day_of_the_week || available.end_day_of_the_week >= booked.start_day_of_the_week
    end

    (available.start_day_of_the_week >= booked.start_day_of_the_week && available.end_day_of_the_week <= booked.end_day_of_the_week) ||
    (available.end_day_of_the_week <= booked.end_day_of_the_week && available.end_day_of_the_week >= booked.start_day_of_the_week)    
  end

  def self.time_overlap(available:, booked:)
    (available.start_time.strftime("%H:%M") >= booked.start_time.strftime("%H:%M") && available.start_time.strftime("%H:%M") <= booked.end_time.strftime("%H:%M")) ||
    (available.end_time.strftime("%H:%M") <= booked.end_time.strftime("%H:%M") && available.end_time.strftime("%H:%M") >= booked.start_time.strftime("%H:%M"))
  end

  def start_day_of_the_week
    start_time.wday
  end

  def end_day_of_the_week
    end_time.wday
  end
end
