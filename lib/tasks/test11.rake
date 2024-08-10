desc "test11"

task test11: :environment do
  d = DailyReport.find(890)
  d.data['report']['payment_statistics']['trial_balance'] = 0
  if d.save
    p d.data
  else
    p 'fail to update'
  end
end