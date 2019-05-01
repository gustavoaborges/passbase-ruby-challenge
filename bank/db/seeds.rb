# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
welcome_user = User.create!(full_name: 'User greeter', email: 'greetings@passbase.com')
gus = User.create!(full_name: 'Gustavo Borges', email: 'gustavoaborges@gmail.com', password: '123457')
mat = User.create!(full_name: 'Mathias Klenk', email: 'mathias@passbase.com', password: '123457')
