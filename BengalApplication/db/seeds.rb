# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setups).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!([{
                  first_name: "Billy",
                  last_name: "Jones",
                  email: "bil@gmail.com",
                  password: "password",
                  user_name: "bil232",
                  teacher_id: nil
              }])

Teacher.create!([{
                     school_name: "Pocatello High School",
                     chaperone_count: 2,
                     user_id: 1
                 }])

User.create!([{
                  first_name: "Tim",
                  last_name: "Dunken",
                  email: "dunkMe@gmail.com",
                  password: "password",
                  user_name: "timmy23db",
                  teacher_id: 1
              }, {
                  first_name: "Ben",
                  last_name: "Smith",
                  email: "student@gmail.com",
                  password: "password",
                  user_name: "firstStudent25",
                  teacher_id: 1
              }, {
                  first_name: "Chuck",
                  last_name: "Norris",
                  email: "Nor@gmail.com",
                  password: "password",
                  user_name: "Strong25Fast",
                  teacher_id: 1
              }, {
                  first_name: "Javier",
                  last_name: "Floris",
                  email: "Javi@gmail.com",
                  password: "password",
                  user_name: "JUnit4Floris",
                  teacher_id: 1
                  #waitlist_id: 2
              }, {
                  first_name: "Emily",
                  last_name: "Udy",
                  email: "Udy@gmail.com",
                  password: "password",
                  user_name: "Emmy2Ballen",
                  teacher_id: 1
              }, {
                  first_name: "Adhar",
                  last_name: "Bhattarai",
                  email: "adhar@gmail.com",
                  password: "password",
                  user_name: "Adhar22",
                  teacher_id: nil

              }, {
                  first_name: "Victor",
                  last_name: "Valdes",
                  email: "Victory@gmail.com",
                  password: "password",
                  user_name: "JustDoIt4Nike",
                  teacher_id: nil
              }, {
                  first_name: "Miriam",
                  last_name: "Dance",
                  email: "dancmiri@isu.edu",
                  password: "password",
                  user_name: "Miriam",
                  teacher_id: nil

              }])

Role.create!([{
                  role_name: "Teacher",
              }, {
                  role_name: "Student",
              }, {
                  role_name: "Sponsor",
              }, {
                  role_name: "Admin",
              }, {
                  role_name: "Coordinator"
              }, {
                  role_name: "Participant"
              }, {
                  role_name: "Organizer"
              }])

Assignment.create!([{
                        user_id: 1,
                        role_id: 1
                    }, {
                        user_id: 2,
                        role_id: 2
                    }, {
                        user_id: 3,
                        role_id: 2
                    }, {
                        user_id: 4,
                        role_id: 2
                    }, {
                        user_id: 5,
                        role_id: 2
                    }, {
                        user_id: 6,
                        role_id: 2
                    }, {
                        user_id: 7,
                        role_id: 3
                    }, {
                        user_id: 8,
                        role_id: 4
                    }, {
                        user_id: 9,
                        role_id: 5
                    }, {
                        user_id: 1,
                        role_id: 6
                    }, {
                        user_id: 2,
                        role_id: 6
                    }, {
                        user_id: 3,
                        role_id: 6
                    }, {
                        user_id: 4,
                        role_id: 6
                    }, {
                        user_id: 5,
                        role_id: 6
                    }, {
                        user_id: 6,
                        role_id: 6
                    }, {
                        user_id: 7,
                        role_id: 7
                    }, {
                        user_id: 9,
                        role_id: 7
                    }, {
                        user_id: 9,
                        role_id: 4
                    }])


Event.create!([{
                   name: "Bengal Stem Day",
                   description: "Stem Related Activities",
                   start_date: DateTime.new(2020, 4, 20)

               }])

Activity.create!([{
                      name: "Robotics",
                      description: "Drive a robot.",
                      equipment: "Boxes to use as obstacles.",
                      ismakeahead: false,
                      iscompetetion: false,
                      identifier: 1,
                      event_id: 1,
                      user_id: 7
                  }, {
                      name: "Raspberry Pi",
                      description: "Learning how to program a raspberry pi",
                      equipment: "None",
                      event_id: 1,
                      user_id: 7,
                      ismakeahead: false,
                      iscompetetion: false,
                      identifier: 2,

                  }, {
                      name: "Developing A Game",
                      description: "Develop a game using python",
                      equipment: "None",
                      event_id: 1,
                      user_id: 9,
                      max_team_size: 2,
                      ismakeahead: false,
                      iscompetetion: true,
                      identifier: 3,
                  }])
Location.create!([{
                      location_name: "SUB",
                      address: "921 S 8th Ave, Pocatello, ID 83209"
                  }])

Room.create!([{
                  room_number: 102,
                  location_id: 1,
                  room_name: "Cafe"
              }, {
                  room_number: 203,
                  location_id: 1,
                  room_name: "Ballroom"
              }, {
                  room_number: 303,
                  location_id: 1,
                  room_name: ""
              }
             ])
Session.create!([{
                     start_time: DateTime.new(2020, 4, 20, 15),
                     end_time: DateTime.new(2020, 4, 20, 16),
                     capacity: 25,
                     activity_id: 1,
                     room_id: 1
                 }, {
                     start_time: DateTime.new(2020, 4, 20, 17),
                     end_time: DateTime.new(2020, 4, 20, 18),
                     capacity: 20,
                     activity_id: 1,
                     room_id: 1
                 }, {
                     start_time: DateTime.new(2020, 4, 20, 13),
                     end_time: DateTime.new(2020, 4, 20, 14),
                     capacity: 10,
                     activity_id: 2,
                     room_id: 1
                 }, {
                     start_time: DateTime.new(2020, 4, 2, 13),
                     end_time: DateTime.new(2020, 4, 3, 14),
                     capacity: 2,
                     activity_id: 2,
                     room_id: 2
                 }, {
                     start_time: DateTime.new(2020, 4, 20, 4),
                     end_time: DateTime.new(2020, 4, 20, 12),
                     capacity: 2,
                     activity_id: 3,
                     room_id: 3
                 }])


Team.create!([{
                  team_name: "Tigers",
                  lead: 2
              }, {
                  team_name: "Lions",
                  lead: 3
              }, {
                  team_name: "Bears",
                  lead: 4
              }])

Grouping.create!([{
                      team_id: 1,
                      user_id: 2
                  }, {
                      team_id: 1,
                      user_id: 4
                  }, {
                      team_id: 1,
                      user_id: 3
                  },
                  {
                      team_id: 2,
                      user_id: 3
                  }, {
                      team_id: 2,
                      user_id: 5
                  }, {
                      team_id: 2,
                      user_id: 2
                  }, {
                      team_id: 3,
                      user_id: 5
                  }, {
                      team_id: 3,
                      user_id: 4
                  }])

Registration.create!([{
                          session_id: 1,
                          user_id: 1
                      }, {
                          session_id: 1,
                          user_id: 2
                      }, {
                          session_id: 2,
                          user_id: 3
                      }, {
                          session_id: 2,
                          user_id: 4
                      }, {
                          session_id: 3,
                          user_id: 1
                      }, {
                          session_id: 3,
                          user_id: 3
                      }, {
                          session_id: 4,
                          user_id: 2
                      }])

TeamRegistration.create!([{
                              session_id: 5,
                              team_id: 1
                          },
                         ])

Waitlist.create!([{
                      session_id: 4
                  }, {
                      session_id: 2
                  }, {
                      session_id: 1
                  }, {
                      session_id: 3
                  }, {
                      session_id: 5
                  }])

if Rails.env == "test"
  Setup.create!([{
                     configure: true
                 }])


  Setting.create!([{
                       primary_color: "#6d6e71",
                       secondary_color: "#f47920",
                       additional_color: "#f69240",
                       font: "Arial",
                       site_name: "Bengal Stem Day"
                   }])
end


p "Done"
