# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Coordinator.create!([{
    name: "Tom",
    user_attributes: {
        email: "tom23@gmail.com",
        password: "password"
    },
    supervisor_attributes: {}
                     },
                    {
    name: "Sam",
    user_attributes: {
        email: "Sam@gmail.com",
        password: "password"
    },
    superviosr_attributes: {}
                     }])
 #
 #EventDetail.create!([{
 #
 #                    }])

Event.create!([{
    name: "Robotics",
    occasion_id: 1,
    supervisor_id: 1,
    description: "All about robots",
    isMakeAhead: false,
    isCompetetion: false
               },
              {
    name: "Chemistry",
    occasion_id: 1,
    supervisor_id: 3,
    description: "Teaching entry chemistry.",
    isMakeAhead: false,
    isCompetetion: false
               },
              {
    name: "Racing",
    occasion_id: 1,
    supervisor_id: 2,
    description: "Racing with cars",
    isMakeAhead: true,
    isCompetetion: true
               },
              {
    name: "Mouse Trap Car",
    occasion_id: 2,
    supervisor_id: 3,
    description: "Build a mousetrap car",
    isMakAhead: true,
    isCompetetion: false
               },
              {
    name: "Wood Carving",
    occasion_id: 1,
    supervisor_id: 2,
    description: "Carve your own objects with wood",
    isMakeAhead: false,
    isCompetetion: true
               }])



Occasion.create!([{
    name: "Bengal Stem Day",
    start_date: 2019-06-25,
    coordinator_id: 1,
    description: "STEM related activities"
                  }])


Sponsor.create!([{
    name: "Carlos"
                 },
                {
    name: "Ben"
                 }])

Supervisor.create!([{
      director_id: 1,
      director_type: "Sponsor"
                   },
                   {
      director_id: 2,
      director_type: "Sponsor"
                    },
                   {
      director_id: 1,
      director_type: "Coordinator"
                    }])


Student.create!([
      {
                    name: "Jimmy Rodrigus",
                    user_attributes: {email: "timmy@gmail.com",
                                      password: "password"},
                    participant_attributes: {}
      },{
                    name: "Catie Madison",
                    user_attributes: {email: "Catie23@gmail.com",
                                      password: "password"},
                    participant_attributes: {}
      },{
                     name: "Billy Thomas",
                     user_attributes:{email: "bil@gmail.com",
                                      passowrd: "password"},
                     participant_attributes:{}
      },{
                     name: "Catie Johnson",
                     user_attributes: {email: "cAt@gmail.com",
                                       password: "password"},
                     participant_attributes: {}
      },{
                     name: "Thomas Wayne",
                     user_attributes: {email: "tom@gmail.com",
                                       password: "password"},
                     participant_attributes: {}
      },{
                     name: "Clark Fin",
                     user_attributes: {email: "clArk@gmail.com",
                                       password: "password"},
                     participant_attributes: {}
      },{
                     name: "David Madison",
                     user_attributes: {email: "dav@gmail.com",
                                       password: "password"},
                     participant_attributes:{}
      },{
                     name: "Cleveland Brown",
                     user_attributes: {email: "cle@gmail.com",
                                       password: "password"},
                     participant_attributes:{}
      },{
                     name: "Glenn Quagmire",
                     user_attributes: {email: "glen@gmail.com",
                                       password: "password"},
                     participant_attributes:{}
      }
                ])

 Teacher.create!([
       {
            name: "Steven Monroe",
            student_count: 8,
            chaperone_count: 2,
            user_attributes: {email: "mon@gmail.com",
                              password: "password"},
            participant_attributes:{}
       }

                  ])

 Team.create!([{
                   name: "Tigers",
                   lead: 1
              },{
                   name: "Lions",
                   lead: 4
               }])




p "Done"
