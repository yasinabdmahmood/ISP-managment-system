desc "task7"
# This task elevates the employees who's name given in admin_plua_names array
# from admin to admin_plus
task task7: :environment do
      admin_plus_names = ['Yaseen', 'Arman','mohamed moyad']
      employee_names = ['muhamad']
      admin_plus_names.each do |name|
      employee = Employee.find_by(name: name)
      employee.update(role: 'admin_plus')
      employee.save
      end
 
      employee_names.each do |name|
        employee = Employee.find_by(name: name)
        employee.update(role: 'employee')
        employee.save
      end
end