user = User.create(
   name: Faker::Name.first_name
)

100.times do
     Project.create(
        name: Faker::Space.planet,
        description: Faker::Space.agency,
        host_user_id: user.id
      )
end
