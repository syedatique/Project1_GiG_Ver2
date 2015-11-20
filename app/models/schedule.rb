class Schedule < ActiveRecord::Base
  belongs_to  :venue
  belongs_to  :gig
  has_many  :bookings
  has_many :users, :through => :bookings

  def human_readable_date
    schedule.strftime("%A, %d %b %Y %I:%M %p")
  end

  def schedule_not_exist_at_venue?(venue_id)
    # Checking if any gig already present withhin +_ 3 HOURS on same day
    duration = 3
    Schedule.where(venue_id: venue_id).all? {|s| s.schedule != self.schedule} && !Schedule.where(venue_id: venue_id).all? {|s| ((s.schedule.strftime("%H").to_i - duration)..(s.schedule.strftime("%H").to_i + duration)).include?(self.schedule.strftime("%H").to_i)} 
    # binding.pry


    
    # after_duration = (s.schedule + (duration/24.0)).strftime("%H:%M")
    # after_duration = s.schedule.strftime("%H").to_i + duration
    # before_duration = s.schedule.strftime("%H").to_i - duration

    # before_duration = (s.schedule - (duration/24.0)).strftime("%H:%M")
    # (before_duration..after_duration).include?(self.schedule.strftime("%H:%M"))
  end

  def number_of_seat_available
    capacity = venue.seat
    total_booking = Booking.where(schedule_id: id).count
    number_of_seat_available = capacity - total_booking
  end

  def seat_availability
    number_available = number_of_seat_available
    venue.seat >= number_available
  end

  def search_result(name)
    gig_matches = Gig.where("name like ?", "%#{name}%")
    venue_matches = Venue.where("name like ?", "%#{name}%")
      # binding.pry
    schedule_gig = gig_matches.map {|gig| Schedule.where(:gig_id => gig.id) }
    schedule_venue = venue_matches.map {|venue| Schedule.where(:venue_id => venue.id) }
    ((schedule_gig + schedule_venue).flatten).uniq
  end


end
