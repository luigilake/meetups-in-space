class CreateAddIndexToAttendees < ActiveRecord::Migration
  def change
    add_index :attendees, [:meetup_id, :user_id], unique: true
  end
end
