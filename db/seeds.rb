# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.username = "charles"
u.password = "12345678"
u.save

u = User.new
u.username = "robert"
u.password = "87654321"
u.save

p = Post.new
p.user_id = 1
p.category = "class"
p.title = "About class registration."
p.content = "I don't know what to do but I want to register for Creative Thinking for Engineers class!!"
p.views = 1
p.votes = 3
p.save
