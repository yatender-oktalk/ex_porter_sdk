defmodule ExPorterSDK.Protocols.Implementations.Structable do
  @moduledoc """
  This module provides protocol implementations for structs that are
  `TypedStruct` compliant.
  """

  alias ExPorterSDK.Protocols.Structable

  alias ExPorterSDK.Structs.Types.AddressLatLng
  alias ExPorterSDK.Structs.Types.CustomerDetails
  alias ExPorterSDK.Structs.Types.ContactDetails
  alias ExPorterSDK.Structs.Types.FareEstimateRequest

  alias ExPorterSDK.Parser

  # Protocol implementations just delegate to parser
  defimpl Structable, for: Map do
    def from_map(%{"pickup_details" => _, "drop_details" => _, "customer" => _} = map),
      do: Parser.parse_fare_estimate(map)

    def from_map(%{"mobile" => _, "name" => _} = map),
      do: Parser.parse_customer(map)

    def from_map(%{"country_code" => _, "number" => _} = map),
      do: Parser.parse_contact(map)

    def from_map(%{"lat" => _, "lng" => _} = map),
      do: Parser.parse_address(map)
  end

  defimpl Structable, for: CustomerDetails do
    def from_map(map), do: Parser.parse_customer(map)
  end

  defimpl Structable, for: ContactDetails do
    def from_map(map), do: Parser.parse_contact(map)
  end

  defimpl Structable, for: FareEstimateRequest do
    def from_map(map), do: Parser.parse_fare_estimate(map)
  end

  defimpl Structable, for: AddressLatLng do
    def from_map(map), do: Parser.parse_address(map)
  end
end
