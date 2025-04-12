namespace :db do
  desc "Seed employees into the database"
  task seed_employees: :environment do
    employees = Employee.create([
      { name: "Test", role: "admin_plus", email: 'test@gmail.com', password: '11111111' }
    ])

    puts "✅ Seeded #{employees.size} employees!"
  end
end
