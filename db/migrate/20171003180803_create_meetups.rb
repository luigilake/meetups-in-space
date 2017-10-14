class CreateMeetups < ActiveRecord::Migration
  def change
    create_table :meetups do |table|
      table.string :name, null: false
      table.text :description, null: false
      table.string :location, null: false
      table.integer :host, null:false
    end
  end
end
