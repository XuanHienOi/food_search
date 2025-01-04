class Api::V1::VendorsController < ApplicationController
  COORDINATES = [
    { latitude: 10.802932678556273, longitude: 106.68664801830207 },
    { latitude: 10.792857648359382, longitude: 106.62202289404496 },
    { latitude: 10.823874795205146, longitude: 106.61557370939718 },
    { latitude: 10.758895354346794, longitude: 106.62567879519817 },
    { latitude: 10.75834363167707, longitude: 106.66929594157959 },
    { latitude: 10.789790211232214, longitude: 106.69737564955048 },
    { latitude: 10.809833391188356, longitude: 106.70430197751665 },
    { latitude: 10.763093412283558, longitude: 106.67312180179063 },
    { latitude: 10.773311451077376, longitude: 106.65738439302524 }
  ]

  def index
    COORDINATES.each do |cor|
      payload = {
        page: params[:page] || 1,
        limit: params[:limit] || 200,
        locale: "vi",
        app_version: "11261",
        version: "1.1.261",
        device_type: 3,
        operator_token: "0b28e008bc323838f5ec84f718ef11e6",
        customer_package_name: "xyz.be.food",
        device_token: "f51bb482c660d0eeadd1f058058a2b35",
        ad_id: "",
        screen_width: 360,
        screen_height: 640,
        client_info: {
          locale: "vi",
          app_version: "11261",
          version: "1.1.261",
          device_type: 3,
          operator_token: "0b28e008bc323838f5ec84f718ef11e6",
          customer_package_name: "xyz.be.food",
          device_token: "f51bb482c660d0eeadd1f058058a2b35",
          ad_id: "",
          screen_width: 360,
          screen_height: 640
        },
        latitude: cor[:latitude] || 10.77253621500006,
        longitude: cor[:longitude] || 106.69798153800008
      }
      vendors = VendorService.get_vendors(payload)
    end
    begin
      vendors = Vendor.all
      render json: { status: "success", data: vendors }, status: :ok
    rescue StandardError => e
      render json: { status: "error", message: e.message }, status: :unprocessable_entity
    end
  end

  def detail
    Vendor.pluck(:restaurant_id).each do |restaurant_id|
      begin
        details = RestaurantService.get_restaurant_details(restaurant_id, latitude = 10.772536215, longitude = 106.697981538)
      rescue StandardError => e
      end
    end
    begin
      render json: { status: 'success', data: Food.count }, status: :ok
    rescue StandardError => e
      render json: { status: 'error', message: e.message }, status: :unprocessable_entity
    end
  end
end
