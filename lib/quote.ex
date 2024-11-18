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
  @behaviour ExPorterSDK.Behaviours.Quote

  alias ExPorterSDK.Parser
  alias ExPorterSDK.Structs.Types.FareEstimateRequest

  # Define known keys that we expect in the params
  @valid_keys ~w(pickup_details drop_details customer)
  @valid_address_keys ~w(lat lng)
  @valid_customer_keys ~w(name mobile)
  @valid_mobile_keys ~w(number country_code)

  @impl ExPorterSDK.Behaviours.Quote
  def get_quote(params) when is_map(params) do
    with {:ok, normalized_params} <- normalize_params(params),
         {:ok, fare_estimate} <- validate_params(normalized_params),
         request_params = FareEstimateRequest.to_map(fare_estimate) do
      impl().get_quote(request_params)
    end
  end

  def get_quote(_params), do: {:error, "Invalid params: Expected a map"}

  defp validate_params(params) do
    case Parser.parse_fare_estimate(params) do
      %FareEstimateRequest{} = fare_estimate -> {:ok, fare_estimate}
      {:error, reason} -> {:error, reason}
    end
  end

  defp normalize_params(params) do
    try do
      normalized = %{
        "pickup_details" =>
          normalize_address(params["pickup_details"] || params[:pickup_details]),
        "drop_details" => normalize_address(params["drop_details"] || params[:drop_details]),
        "customer" => normalize_customer(params["customer"] || params[:customer])
      }

      {:ok, normalized}
    rescue
      _ -> {:error, "Invalid params structure"}
    end
  end

  defp normalize_address(nil), do: nil

  defp normalize_address(address) when is_map(address) do
    %{
      "lat" => get_value(address, :lat),
      "lng" => get_value(address, :lng)
    }
  end

  defp normalize_customer(nil), do: nil

  defp normalize_customer(customer) when is_map(customer) do
    %{
      "name" => get_value(customer, :name),
      "mobile" => normalize_mobile(get_value(customer, :mobile))
    }
  end

  defp normalize_mobile(nil), do: nil

  defp normalize_mobile(mobile) when is_map(mobile) do
    %{
      "number" => get_value(mobile, :number),
      "country_code" => get_value(mobile, :country_code)
    }
  end

  defp get_value(map, key) when is_map(map) do
    map[key] || map[to_string(key)]
  end

  defp impl do
    Application.get_env(:ex_porter_sdk, :quote_impl, ExPorterSDK.Quote.Impl)
  end
end
