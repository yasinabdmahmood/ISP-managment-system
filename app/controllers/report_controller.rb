class ReportController < ApplicationController

    def get_daily_report
        # Extract year, month, and day from params
        year = params[:date][:year].to_i
        month = params[:date][:month].to_i
        day = params[:date][:day].to_i
      
        # Create a Date object for the first day of the specified month and year
        date_to_query = Date.new(year, month, 1)

        # Find the monthly report created in the specified month and year
        monthly_report = MonthlyReport.find_by(year: year, month: month)
      
        if daily_report
          render json: daily_report
        else
          render json: { error: "No daily report found for the specified date" }, status: :not_found
        end
      end

      def get_monthly_report
        # Extract year and month from params
        year = params[:date][:year].to_i
        month = params[:date][:month].to_i
      
        # Create a Date object for the first day of the specified month and year
        start_date = Date.parse("#{year}-#{month}-1")
        end_date = Date.parse("#{year}-#{month}-28")
      
        # Find the monthly report created in the specified month and year
        monthly_report = MonthlyReport.find_by(created_at: start_date.beginning_of_day..end_date.end_of_day)
      
        if monthly_report
          render json: monthly_report
        else
          render json: { error: "No monthly report found for the specified year and month" }, status: :not_found
        end
      end
      
      

end
