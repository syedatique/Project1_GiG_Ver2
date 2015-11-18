class Search < ActiveRecord::Base

  def self.search_result(name)
    gig_matches = Gig.where("name like ?", "%#{"name"}%")
    venue_matches = Venue.where("name like ?", "%#{"name"}%")
    schedule_gig = Schedule.where(:gig_id => gig_matches.id)
    schedule_venue = Schedule.where(:venue_id => venue_matches.id)
    schedule_gig + schedule_venue
    # results.uniq
  end

end