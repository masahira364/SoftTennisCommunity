# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Prefecture.create!(
	name: "東京都"
	)

Team.create!(
	name: "チームA",
	slogan: "頑張る",
	address: "東京",
	practice_day: "毎週木曜日",
	number_of_people: 5,
	average_age: 25,
	annual_fee: 1000,
	entry_fee: 500,
	members_wanted: "募集中",
	introduction: "よろしく",
	)