require 'faker'
require 'cpf_faker'

Faker::Config.locale = 'pt-BR'

puts "Destroying existing records..."
User.destroy_all
Debt.destroy_all
Payment.destroy_all
Person.destroy_all

User.create email: 'admin@admin.com', password: '111111'

puts "Usuário criado:"
puts "login admin@admin.com"
puts "111111"

100.times do |user_counter|
  puts "Creating user #{user_counter}"
  User.create email: Faker::Internet.email, password: '111111'
end

300.times do |person_counter|
  puts "Inserting Person #{person_counter}"

  person = Person.create(
    name: Faker::Name.name,
    phone_number: Faker::PhoneNumber.phone_number,
    national_id: Faker::CPF.numeric,
    active: [true, false].sample,
    user: User.order('random()').first
  )

  5.times do |debt_counter|
    puts "Inserting Debt #{debt_counter}"
    person.debts.create(
      amount: Faker::Number.between(from: 1, to: 200),
      observation: Faker::Lorem.paragraph
    )
  end
  
end

100.times do |payment_counter|
  puts "Inserting Payment #{payment_counter}"

  Payment.create(
    amount: Faker::Number.between(from: 1, to: 500), 
    paid_at: Faker::Time.between(from: 2.years.ago, to: Time.current),
    person: Person.all.sample
  )
end