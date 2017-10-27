class AirbnbScrapeService
  AIRBNB_URL = 'https://www.airbnb.com/wmpw_data'.freeze

  def initialize(latitude, longitude)
    @params = {
      page: 'slash_host',
      duration: '1_month',
      person_capacity: '2',
      room_type: 'entire_home_apt',
      occupancy_rate: '100',
      sw_lat: latitude,
      sw_lng: longitude,
      ne_lat: latitude,
      ne_lng: longitude
    }
  end

  def call
    request = HTTP.headers(accept: 'application/json')
                  .get(AIRBNB_URL, params: @params)
    result = request.parse

    result['data'] ? result['data']['average_income_raw'].to_f : nil
  rescue HTTP::ConnectionError, JSON::ParserError
    nil
  end
end
