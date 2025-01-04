require 'httparty'

class RestaurantService
  BASE_URL = 'https://gw.be.com.vn/api/v1/be-marketplace/web/restaurant/detail'

  def self.get_restaurant_details(restaurant_id, latitude, longitude)
    headers = {
      'accept' => '*/*',
      'accept-language' => 'vi-VN,vi;q=0.9,fr-FR;q=0.8,fr;q=0.7,en-US;q=0.6,en;q=0.5,ja;q=0.4,jv;q=0.3',
      'app_version' => '11261',
      'authorization' => 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjowLCJhdWQiOiJndWVzdCIsImV4cCI6MTczNjA2NzQ3MiwiaWF0IjoxNzM1OTgxMDcyLCJpc3MiOiJiZS1kZWxpdmVyeS1nYXRld2F5In0.xdgywo_bQIytX9GBfu4elGkdJvTy-jQMaSOrkNSINz4',
      'content-type' => 'application/json',
      'origin' => 'https://food.be.com.vn',
      'priority' => 'u=1, i',
      'referer' => 'https://food.be.com.vn/',
      'sec-ch-ua' => '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
      'sec-ch-ua-mobile' => '?0',
      'sec-ch-ua-platform' => '"Windows"',
      'sec-fetch-dest' => 'empty',
      'sec-fetch-mode' => 'cors',
      'sec-fetch-site' => 'same-site',
      'user-agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
    }

    payload = {
      restaurant_id: restaurant_id,
      locale: 'vi',
      app_version: '11261',
      version: '1.1.261',
      device_type: 3,
      operator_token: '0b28e008bc323838f5ec84f718ef11e6',
      customer_package_name: 'xyz.be.food',
      device_token: 'f51bb482c660d0eeadd1f058058a2b35',
      ad_id: '',
      screen_width: 360,
      screen_height: 640,
      client_info: {
        locale: 'vi',
        app_version: '11261',
        version: '1.1.261',
        device_type: 3,
        operator_token: '0b28e008bc323838f5ec84f718ef11e6',
        customer_package_name: 'xyz.be.food',
        device_token: 'f51bb482c660d0eeadd1f058058a2b35',
        ad_id: '',
        screen_width: 360,
        screen_height: 640
      },
      latitude: latitude,
      longitude: longitude
    }

    response = HTTParty.post(BASE_URL, headers: headers, body: payload.to_json)
    if response.success?
      categories = response.parsed_response.dig('data', 'categories')
      categories.each do |ca|
        items = ca.dig('items') || []
        items.each do |item|
          Food.create_or_find_by(restaurant_item_id: item['restaurant_item_id']) do |food|
            food.restaurant_id = item['restaurant_id']
            food.restaurant_name = item['restaurant_name']
            food.restaurant_address = item['restaurant_address']
            food.price = item['price']
            food.old_price = item['old_price']
            food.item_name = item['item_name']
            food.item_details = item['item_details']
          end
        end
      end

    else
      raise "API Error: #{response.code} - #{response.message}"
    end
  end
end
