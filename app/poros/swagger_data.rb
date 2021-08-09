class SwaggerData
  def self.holidays
    holiday_array = []
    holidays = HolidayServices.get_us_holidays
    holidays.each_with_index.filter_map do |hol, i|
      if i < 3
        hash = {}
        hash[:name] = hol['name']
        hash[:date] = hol['date']
        holiday_array << hash
      end
    end
    holiday_array
  end
end
