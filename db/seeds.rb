user = User.create(
   name: Faker::Name.first_name,
   uid: Faker::Bitcoin.address,
   provider: "sns"
)

100.times do
     Project.create(
        name: Faker::Space.planet,
        description: Faker::Space.agency,
        user_id: user.id
      )
end
# please sign up before seeds.rb
10.times do
     Project.create(
        name: Faker::Science.element,
        description: Faker::Science.scientist,
        user_id: 1
      )
end
