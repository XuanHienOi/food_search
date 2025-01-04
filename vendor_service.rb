require 'httparty'

class VendorService
  BASE_URL = 'https://gw.be.com.vn/api/v1/be-marketplace/web'

  def self.get_vendors(payload)
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

    response = HTTParty.post("#{BASE_URL}/get_vendors", headers: headers, body: payload.to_json)
    if response.success?
      vendors = response.parsed_response['data'] || []
      vendors.each do |vendor_data|
        Vendor.create_or_find_by(restaurant_id: vendor_data['restaurant_id']) do |vendor|
          vendor.classify = vendor_data['classify']
          vendor.name = vendor_data['name']
          vendor.rating = vendor_data['rating']
          vendor.latitude = vendor_data['latitude']
          vendor.longitude = vendor_data['longitude']
          vendor.display_address = vendor_data['display_address']
          vendor.address = vendor_data['address']
          vendor.city = vendor_data['city']
        end
      end

    else
      raise "API Error: #{response.code} - #{response.message}"
    end
  end
end
