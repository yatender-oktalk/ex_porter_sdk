defmodule ExPorterSDK.Webhook.Impl do
  @moduledoc "Handles webhook-related operations"

  # def create(_config, _params) do
  #   %Types.FareEstimateRequest{
  #     customer: %Types.CustomerDetails{name: "Yatender Singh", mobile: "8105139417"},
  #     pickup_details: %Types.AddressLatLng{lat: 28.6333, lng: 77.2167},
  #     drop_details: %Types.AddressLatLng{lat: 28.6333, lng: 77.2167}
  #   }
  # end

  def verify_webhook(_config, _params) do
    :ok
  end
end
