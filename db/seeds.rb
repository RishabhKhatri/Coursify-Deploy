# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Teacher.create!(name: "Admin Teacher",
                email: "admin.teacher@coursify.in",
                contact: "8505915101",
                expertise: "None",
                password: "foobar",
                password_confirmation: "foobar",
                admin: true,
                activated: true,
                activated_at: Time.zone.now)

Student.create!(name: "Admin Student",
                email: "admin.student@coursify.in",
                contact: "8505915101",
                dob: "06-12-1997",
                password: "foobar",
                password_confirmation: "foobar",
                admin: true,
                activated: true,
                activated_at: Time.zone.now)
