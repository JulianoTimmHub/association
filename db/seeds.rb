# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
require 'cpf_faker'

Faker::Config.locale = 'pt-BR'

puts "Destroying existing records..."
User.destroy_all
Debt.destroy_all
Person.destroy_all

User.create email: 'admin@admin.com', password: '111111'

puts "Usuário criado:"
puts "login admin@admin.com"
puts "111111"

1000.times do |counter|
  puts "Creating user #{counter}"
  User.create email: Faker::Internet.email, password: '111111'
end

3000.times do |counter|
  puts "Inserting Person #{counter}"

  attrs = {
    name: Faker::Name.name,
    phone_number: Faker::PhoneNumber.phone_number,
    national_id: Faker::CPF.numeric,
    active: [true, false].sample,
    user: User.order('random()').first
  }
  person = Person.create(attrs)

  5.times do |debt_counter|
    puts "Inserting Debt #{debt_counter}"
    person.debts.create(
      amount: Faker::Number.between(from: 1, to: 200),
      observation: Faker::Lorem.paragraph
    )
  end
end