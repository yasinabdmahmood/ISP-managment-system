desc "test6"

task test6: :environment do
      admin_plus_names = ['Yaseen', 'Arman']
      admin_plus_names.each do |name|
      employee = Employee.find_by(name: name)
      employee.update(role: 'admin_plus')
      employee.save
      end
end