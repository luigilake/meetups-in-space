class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :meetup
  validates_uniqueness_of :meetup, scope: :user
end
