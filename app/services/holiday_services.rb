class HolidayServices
  def self.get_us_holidays
    response = Faraday.get 'https://date.nager.at/api/v2/NextPublicHolidays/US'
    body = response.body
    JSON.parse(body)
  end
end
