# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

employees = Employee.create([
    { name: "Yaseen", role: "admin", email: 'abd181103@gmail.com', password: '123456'},
    { name: "Arman", role: "admin", email: 'arman@gmail.com', password: '123456' },   
])

# employee_contact_informaton = EmployeeContactInformation.create([
#     {employee: employees[0], contact_info: '07501257896'},
#     {employee: employees[1], contact_info: '07704681278'},
#     {employee: employees[2], contact_info: '07705684712'},
#     {employee: employees[4], contact_info: '07506851247'},
#     {employee: employees[0], contact_info: '07734519763'},
#     {employee: employees[1], contact_info: '07804597512'},
#     {employee: employees[2], contact_info: '07501985478'},
#     {employee: employees[3], contact_info: '07501789635'},
# ])

# clients = Client.create([
#     {name: 'client_1', username: 'client1'},
#     {name: 'client_2', username: 'client2'},
#     {name: 'client_3', username: 'client3'},
#     {name: 'client_4', username: 'client4'},
#     {name: 'client_5', username: 'client5'},
#     {name: 'client_6', username: 'client6'},
#     {name: 'client_7', username: 'client7'},
#     {name: 'client_8', username: 'client8'},
#     {name: 'client_9', username: 'client9'},
#     {name: 'client_10', username: 'client10'},
# ])

# client_contact_informations = ClientContactInformation.create([
#     {client: clients[0], contact_info: '07504598712'},
#     {client: clients[1], contact_info: '07702657894'},
#     {client: clients[2], contact_info: '07701478563'},
#     {client: clients[3], contact_info: '07804598521'},
#     {client: clients[4], contact_info: '07701458797'},
#     {client: clients[5], contact_info: '07501478965'},
#     {client: clients[6], contact_info: '07501254789'},
#     {client: clients[7], contact_info: '07701459862'},
#     {client: clients[8], contact_info: '07707821984'},
#     {client: clients[9], contact_info: '07505687814'},
# ])

# subscription_types = SubscriptionType.create([
#     {category: 'Economic',cost: 38000, profit: 5000},
#     {category: 'Standard',cost: 45000, profit: 8000},
#     {category: 'Business',cost: 70000, profit: 10000},
# ])

# subscription_records = SubscriptionRecord.create([
#     {client: clients[0], employee: employees[0], subscription_type: subscription_types[0], is_fully_paid: false, pay: 30000},
#     {client: clients[1], employee: employees[1], subscription_type: subscription_types[0], is_fully_paid: false, pay: 40000},
#     {client: clients[2], employee: employees[2], subscription_type: subscription_types[0], is_fully_paid: false, pay: 0},
#     {client: clients[3], employee: employees[3], subscription_type: subscription_types[0], is_fully_paid: false, pay: 0},
#     {client: clients[4], employee: employees[4], subscription_type: subscription_types[1], is_fully_paid: false, pay: 0},
#     {client: clients[5], employee: employees[0], subscription_type: subscription_types[0], is_fully_paid: false, pay: 0},
#     {client: clients[6], employee: employees[1], subscription_type: subscription_types[2], is_fully_paid: true, pay: 70000},
#     {client: clients[7], employee: employees[2], subscription_type: subscription_types[0], is_fully_paid: false, pay: 0},
#     {client: clients[8], employee: employees[3], subscription_type: subscription_types[2], is_fully_paid: false, pay: 0},
#     {client: clients[9], employee: employees[4], subscription_type: subscription_types[1], is_fully_paid: false, pay: 0},
# ])

# start_time = 1.year.ago
# interval = 5.hours


# 1000.times do |idx|
#     sampled_employee = Employee.all.sample
#     sampled_subscription_type =  SubscriptionType.all.sample
#     sampled_pay = (0..sampled_subscription_type.cost).step(1000).to_a.sample
#     random_time = start_time + idx*interval
#     sb = SubscriptionRecord.create(
#       employee: sampled_employee,
#       client: Client.all.sample,
#       subscription_type: sampled_subscription_type,
#       is_fully_paid: [true, false].sample,
#       pay: sampled_pay,
#       created_at: random_time,
#     )

#     PaymentRecord.create(
#       subscription_record: sb,
#       employee: sampled_employee,
#       amount: sampled_pay,
#       created_at: random_time,
#     )
#   end
