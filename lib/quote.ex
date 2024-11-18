defmodule ExPorterSDK.Quote do
  @moduledoc """
  Quote operations dispatcher based on environment.

  ### Example

  params = %{
    pickup_details: %{lat: 12.909728534457143, lng: 77.6001397394293},
    drop_details: %{lat: 12.89795704454522, lng: 77.62119799020186},
    customer: %{
      name: "Porter Test User",
      mobile: %{number: "7678139714", country_code: "+91"}
    }
  }

  {:ok, quote} = ExPorterSDK.Quote.get_quote(params)
  """

  def get_quote(params) do
    impl().get_quote(params)
  end

  defp impl do
    Application.get_env(:ex_porter_sdk, :quote_impl, ExPorterSDK.Quote.Impl)
  end
end
