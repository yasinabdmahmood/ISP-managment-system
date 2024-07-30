desc "test6"
require 'date'
  task test6: :environment do
    amounts = [55000, 60000, 65000,7000, 7500, 8000, 8500, 9000, 9500, 10000]
    dates = [Date.today, Date.yesterday, Date.tomorrow]
    account_options_ids = [1, 2]
    
    
    # Iterate over the arrays
    30.times do |i|
      expense = Expense.new(
        amount: amounts.sample,
        date: dates.sample,
        remark: "some comment",
        status: "pending",
        account_option: AccountOption.find(account_options_ids.sample)
      )
    
      if expense.save
        puts "Record saved successfully: #{expense.inspect}"
      else
        puts "Failed to save the record: #{expense.errors.full_messages.join(', ')}"
      end
    end
end