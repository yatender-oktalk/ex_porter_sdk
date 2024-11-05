# defmodule ExPorterSDK.Protocols.Implementations.Validatable do
#   @moduledoc "Custom implementations for protocols"

#   alias ExPorterSDK.Structs.Types.FareEstimateRequest
#   alias ExPorterSDK.Structs.Types.AddressLatLng
#   alias ExPorterSDK.Structs.Types.CustomerDetails

#   alias ExPorterSDK.Protocols.Mappable
#   alias ExPorterSDK.Protocols.Validatable

#   defimpl Mappable, for: FareEstimateRequest do
#     def to_map(struct) do
#       struct
#       |> Map.from_struct()
#       |> Map.new(fn
#         {:pickup_details, v} -> {:pickup_details, Mappable.to_map(v)}
#         {:drop_details, v} -> {:drop_details, Mappable.to_map(v)}
#         {:customer, v} -> {:customer, Mappable.to_map(v)}
#         pair -> pair
#       end)
#     end
#   end

#   defimpl Validatable, for: AddressLatLng do
#     def validate(%{lat: lat, lng: lng}) do
#       cond do
#         not is_float(lat) -> {:error, "latitude must be a float"}
#         not is_float(lng) -> {:error, "longitude must be a float"}
#         lat < -90 or lat > 90 -> {:error, "latitude must be between -90 and 90"}
#         lng < -180 or lng > 180 -> {:error, "longitude must be between -180 and 180"}
#         true -> :ok
#       end
#     end
#   end

#   defimpl Validatable, for: CustomerDetails do
#     def validate(%{name: name, mobile: mobile}) do
#       cond do
#         is_nil(name) or String.trim(name) == "" ->
#           {:error, "name is required"}

#         not is_nil(mobile) and not valid_phone_number?(mobile) ->
#           {:error, "invalid mobile number format"}

#         true ->
#           :ok
#       end
#     end

#     defp valid_phone_number?(nil), do: true

#     defp valid_phone_number?(number) do
#       String.match?(number, ~r/^\d{10}$/)
#     end
#   end

#   defimpl Validatable, for: FareEstimateRequest do
#     def validate(struct) do
#       with :ok <- validate_pickup_details(struct.pickup_details),
#            :ok <- validate_drop_details(struct.drop_details),
#            :ok <- validate_customer(struct.customer) do
#         :ok
#       end
#     end

#     defp validate_pickup_details(nil), do: {:error, "pickup_details is required"}
#     defp validate_pickup_details(details), do: Validatable.validate(details)

#     defp validate_drop_details(nil), do: {:error, "drop_details is required"}
#     defp validate_drop_details(details), do: Validatable.validate(details)

#     defp validate_customer(nil), do: {:error, "customer is required"}
#     defp validate_customer(customer), do: Validatable.validate(customer)
#   end
# end
