# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.find_or_create_by!(full_name: 'User greeter') do |u|
  u.email = 'greetings@passbase.com'
  u.password = 'somethingRidicoulos'
end
User.find_or_create_by!(full_name: 'Gustavo Borges') do |u|
  u.email = 'gustavoaborges@gmail.com'
  u.password = '123457'
end
User.find_or_create_by!(full_name: 'Mathias Klenk') do |u|
  u.email = 'mathias@passbase.com'
  u.password = '123457'
end
