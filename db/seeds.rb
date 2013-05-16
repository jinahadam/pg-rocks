# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Post.find_or_create_by_title('Postgres is awesome')
Post.find_or_create_by_title('Oracle something database')
Post.find_or_create_by_title('Postgres is different from mysql')
Post.find_or_create_by_title('Tips for mysql refugees')
p = Post.find_or_create_by_title('TOP SECRET')
p.body = "Postgress rocks"
p.save
