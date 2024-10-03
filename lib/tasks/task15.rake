desc "task15"
# Set the actual_creation_time filed equal to created_at fileld
# for all the records in both table payment_records and subscription_records
# if thier value is nil
 
task task15: :environment do
    PaymentRecord.where(actual_creation_time: nil).update_all('actual_creation_time = created_at')
    SubscriptionRecord.where(actual_creation_time: nil).update_all('actual_creation_time = created_at')

end
