# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

Community.destroy_all
User.destroy_all
Member.destroy_all


#Users
  User.create(
    first_name: "Dan",
    last_name: "Bertrand",
    email: 'user' + '1' + '@community.com',
    password: 'bonjour',
  )

  User.create(
    first_name: "Gary",
    last_name: "Bertrand",
    email: 'user' + '2' + '@community.com',
    password: 'bonjour',
  )

  User.create(
    first_name: "Kevin",
    last_name: "Bertrand",
    email: 'user' + '3' + '@community.com',
    password: 'bonjour',
  )

puts '-------------------- Users table --------------------'
tp User.all


#Communities
Community.create(
  name: "Good Vibes",
  address: 'Seestrasse 114, 13353 Berlin',
)
Community.create(
  name: "NomadLand",
  address: '10 D114A, 38350 Oris-en-Rattier, France',
)
puts '-------------------- Community table --------------------'
tp Community.all


#Members
Member.create(
  user_id:1,
  community_id:1,
  role: 'creator'
)
Member.create(
  user_id:1,
  community_id:2,
)
Member.create(
  user_id:2,
  community_id:2,
  role: 'creator'
) 
Member.create(
  user_id:3,
  community_id:3,
  role: 'creator'
) 
puts '-------------------- Member table --------------------'
tp Member.all