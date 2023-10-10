desc "test both agent and ledger tables"
require 'date'
task task6: :environment do

    # names = ["John", "Jane", "Bob", "Alice", "Eva"]
    # names.each do |name|
    #     agent = Agent.create(
    #         name: name,
    #         info: "This is test info for #{name}"
    #     )   
    # end
    Ledger.all.each do |ledger|
        ledger.destroy
    end
    agents = Agent.all
    agents.each_with_index do |agent,idx|
        ledger = Ledger.new(
            agent: agent,
            date: Date.parse("2023-5-1"),
            withdraw: 50000,
            deposit: 0,
            detail: {type1: 25000, type2: 25000}
        )

        if ledger.save
            puts "Ledger #{agent.name} saved successfully."
          else
            puts "Agent #{agent.name} could not be saved. Errors: #{ledger.errors.full_messages.join(', ')}"
          end
    end

    p Ledger.all.count
end