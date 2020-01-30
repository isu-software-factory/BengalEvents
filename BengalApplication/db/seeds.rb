# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
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
              },{
                  first_name: "Tim",
                  last_name: "Dunken",
                  email: "dunkMe@gmail.com",
                  password: "password",
                  user_name: "timmy23db"
              },{
                  first_name: "Ben",
                  last_name: "Smith",
                  email: "student@gmail.com",
                  password: "password",
                  user_name: "firstStudent25"
              },{
                  first_name: "Chuck",
                  last_name: "Norris",
                  email: "Nor@gmail.com",
                  password: "password",
                  user_name: "Strong25Fast"
              },{
                  first_name: "Javier",
                  last_name: "Floris",
                  email: "Javi@gmail.com",
                  password: "password",
                  user_name: "JUnit4Floris"
              },{
                  first_name: "Emily",
                  last_name: "Udy",
                  email: "Udy@gmail.com",
                  password: "password",
                  user_name: "Emmy2Ballen"
              },{
                  first_name: "Adhar",
                  last_name: "Bhattarai",
                  email: "Adhar@gmail.com",
                  password: "password",
                  user_name: "Adhar22"
              },{
                  fist_name: "Victor",
                  last_name: "Valdes",
                  email: "Victory@gmail.com",
                  password: "password",
                  user_name: "JustDoIt4Nike"
              },{
                  first_name: "Miriam",
                  last_name: "Dance",
                  email: "dancmiri@isu.edu"
              }])


Assignment.create!([{
                        user_id: 1,
                        role_id: 1
                    },{
                        user_id: 2,
                        role_id: 2
                    },{
                        user_id: 3,
                        role_id: 2
                    },{
                        user_id: 4,
                        role_id: 2
                    },{
                        user_id: 5,
                        role_id: 2
                    },{
                        user_id: 6,
                        role_id: 2
                    },{
                        user_id: 7,
                        role_id: 3
                    },{
                        user_id: 8,
                        role_id: 4
                    },{
                        user_id: 9,
                        role_id: 5
                    }])


Role.create!([{
                  role_name: "Teacher",
                  role_name: "Student",
                  role_name: "Admin",
                  role_name: "Sponsor",
                  role_name: "Coordinator"
              }])




Event.create!([{
                   name: "Bengal Stem Day",
                   description: "Stem Related Activities",
                   start_date: DateTime.new(2020,4,20)

               }])

Activity.create!([{
                      name: "Robotics",
                      description: "Drive a robot.",
                      equipment: "Boxes to use as obstacles.",
                      # need to finish
                  },{
                      name: "Raspberry Pi",
                      description: "Learning how to program a raspberry pi",
                      equipment: "None"
                      # need to finish
                  }])

Sessison.create!({
                     start_time: DateTime.new(2020,4,20,15),
                     end_time: DateTime.new(2020,4,20,16),
                     capacity: 25,
                     activity_id: 1
                 },{
                     start_time: DateTime.new(2020,4,20,17),
                     end_time: DateTime.new(2020, 4,20, 18),
                     capacity: 20,
                     activity_id: 1
                 },{
                     start_time: DateTime.new(2020,4,20,13),
                     end_time: DateTime.new(2020,4,20,14),
                     capacity: 10,
                     activity_id: 2
                 })


 #Team.create!([{
 #                  name: "Tigers",
 #                  lead: 2
 #             },{
 #                  name: "Lions",
 #                  lead: 4
 #              }])




p "Done"
