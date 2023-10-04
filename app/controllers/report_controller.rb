class ReportController < ApplicationController

    def get_daily_report
        # Extract year, month, and day from params
        year = params[:date][:year].to_i
        month = params[:date][:month].to_i
        day = params[:date][:day].to_i
      
        # Create a Date object from the parameters
        # date_to_query = Date.new(year, month, day)
        date_to_query = Date.parse("#{year}-#{month}-#{day}")
       
        # Find the first daily report created on the specified date
        daily_report = DailyReport.find_by(created_at: date_to_query.beginning_of_day..date_to_query.end_of_day)
      
        if daily_report
          render json: daily_report
        else
          render json: { error: "No daily report found for the specified date" }, status: :not_found
        end
      end

      def get_monthly_report
        year = params[:date][:year].to_i
        month = params[:date][:month].to_i
      end
      

end
