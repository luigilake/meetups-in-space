# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Example:
#
#   Person.create(first_name: 'Eric', last_name: 'Kelly')


people = [
  {
    provider: "github",
    uid: "2",
    username: "Gandalf The Grey",
    email: "gandalf@lotr.com",
    avatar_url: "https://vignette.wikia.nocookie.net/lotr/images/8/8d/Gandalf-2.jpg/revision/latest?cb=20130209172436"
  },
  {
    provider: "github",
    uid: "3",
    username: "Legolas",
    email: "legolas@lotr.com",
    avatar_url: "https://upload.wikimedia.org/wikipedia/en/2/2b/Legolas600ppx.jpg"
  },
  {
    provider: "github",
    uid: "4",
    username: "Gimli",
    email: "gimli@lotr.com",
    avatar_url: "https://vignette1.wikia.nocookie.net/lotr/images/e/ec/Gimli_-_FOTR.png/revision/latest?cb=20121008105956"
  },
  {
    provider: "github",
    uid: "5",
    username: "Arwen",
    email: "arwen@lotr.com",
    avatar_url: "https://vignette.wikia.nocookie.net/lotr/images/d/dd/100_beautiful_arwen.jpg/revision/latest?cb=20110313201140"
  },
  {
    provider: "github",
    uid: "6",
    username: "Elrond",
    email: "elrond@lotr.com",
    avatar_url: "https://vignette2.wikia.nocookie.net/lotr/images/3/39/Elrond_in_Rivendell_-_The_Hobbit.jpg/revision/latest?cb=20121118121504"
  },
  {
    provider: "github",
    uid: "7",
    username: "Galadriel",
    email: "galadriel@lotr.com",
    avatar_url: "https://www.wordonfire.org/wof-core/libraries/timthumb/timthumb.php?zc=1&w=1328&h=598&src=https://www.wordonfire.org/wof-site/media/brgimligaladriel.jpg"
  }
]

people.each do |person|
  User.create(person)
end

meetups = [
  {
    name: "Aeroplanes in Atlantis",
    description: "but it's underwater?",
    location: "Atlantis",
    host: User.all[0].id
  },
  {
    name: "Viruses in Venus",
    description: "see if you survive",
    location: "Venus",
    host: User.all[1].id
  },
  {
    name: "Mashing Potatoes in Mercury",
    description: "best place to do it",
    location: "Mercury",
    host: User.all[2].id
  },
  {
    name: "(Anti)Nicotine in Neptune",
    description: "stop the nicotine",
    location: "Neptune",
    host: User.all[1].id
  }
]

meetups.each do |meetup|
  Meetup.create(meetup)
end

attendees = [
  {
    user: User.all[1],
    meetup: Meetup.all[0]
  },
  {
    user: User.all[2],
    meetup: Meetup.all[0]
  },
  {
    user: User.all[2],
    meetup: Meetup.all[1]
  },
  {
    user: User.all[0],
    meetup: Meetup.all[2]
  },
  {
    user: User.all[0],
    meetup: Meetup.all[3]
  },
  {
    user: User.all[2],
    meetup: Meetup.all[1]
  },
  {
    user: User.all[3],
    meetup: Meetup.all[1]
  },
  {
    user: User.all[4],
    meetup: Meetup.all[3]
  },
  {
    user: User.all[4],
    meetup: Meetup.all[2]
  },
  {
    user: User.all[5],
    meetup: Meetup.all[0]
  },
  {
    user: User.all[5],
    meetup: Meetup.all[3]
  },
  {
    user: User.all[5],
    meetup: Meetup.all[2]
  }
]

attendees.each do |attendee|
  Attendee.create(attendee)
end
