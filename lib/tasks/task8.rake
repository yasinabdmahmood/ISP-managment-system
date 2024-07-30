desc "task8"
# This task updates all the expense records and sets thier employee to Yaseen
task task8: :environment do
      yaseen = Employee.find_by(name: 'Yaseen')
      Expense.all.each do |expense|
      expense.employee = yaseen
      expense.save
      end
end