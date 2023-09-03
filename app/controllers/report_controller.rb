class ReportController < ApplicationController
    def get_daily_report
        daily_report = DailyReport.last
        render json: daily_report
    end

    
end
