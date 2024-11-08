defmodule ExPorterSDK.Protocols.Implementations.Mappable do
  @moduledoc """
  Protocol implementation for mappable structs.
  """

  alias ExPorterSDK.Structs.Types.FareEstimateRequest
  alias ExPorterSDK.Structs.Types.AddressLatLng
  alias ExPorterSDK.Structs.Types.CustomerDetails
  alias ExPorterSDK.Structs.Types.ContactDetails

  alias ExPorterSDK.Protocols.Mappable

  defimpl Mappable, for: FareEstimateRequest do
    @spec to_map(FareEstimateRequest.t()) :: map() | {:error, String.t()}
    @doc """
    Converts a FareEstimateRequest struct to a map.

    ## Parameters
      - request: A FareEstimateRequest struct.

    ## Returns
      - A map representation of the FareEstimateRequest or an error tuple.
    """
    def to_map(%FareEstimateRequest{} = request) do
      %{
        pickup_details: AddressLatLng.to_map(request.pickup_details),
        drop_details: AddressLatLng.to_map(request.drop_details),
        customer: CustomerDetails.to_map(request.customer)
      }
    end
  end

  defimpl Mappable, for: CustomerDetails do
    @spec to_map(CustomerDetails.t()) :: map() | {:error, String.t()}
    @doc """
    Converts a CustomerDetails struct to a map.

    ## Parameters
      - customer: A CustomerDetails struct.

    ## Returns
      - A map representation of the CustomerDetails or an error tuple.
    """
    def to_map(%CustomerDetails{} = customer) do
      %{
        name: customer.name,
        mobile: ContactDetails.to_map(customer.mobile)
      }
    end
  end
end
