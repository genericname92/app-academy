# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



colors = %w(ginger yellow brown calico buff marmalade orange seal chocolate)
sex = %w(M F)
name = %w(Gizmo Hector George Ringo Harrison Jared BlueJeans IceCream)
days = [200, 500, 600, 1200, 1432, 6000]

8.times {

  Cat.create!(name: name.sample, color: colors.sample, sex: sex.sample,
              birth_date: (days.sample).days.ago
  )

}

Cat.create!(name: 'Yoda', color: colors.sample, sex: sex.sample,
            birth_date: 900000.days.ago)
