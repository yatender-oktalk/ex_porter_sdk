defmodule ExPorterSDK.Structs.Types.FareEstimateRequest do
  use TypedStruct

  alias ExPorterSDK.Protocols.Mappable
  alias ExPorterSDK.Protocols.Validatable
  alias ExPorterSDK.Protocols.Structable

  alias ExPorterSDK.Structs.Types.AddressLatLng
  alias ExPorterSDK.Structs.Types.CustomerDetails

  typedstruct do
    field :pickup_details, AddressLatLng.t(), enforce: true
    field :drop_details, AddressLatLng.t(), enforce: true
    field :customer, CustomerDetails.t(), enforce: true
  end

  def validate_struct(struct), do: Validatable.validate(struct)
  def to_map(struct), do: Mappable.to_map(struct)
  def from_map(map), do: Structable.from_map(map)
end
