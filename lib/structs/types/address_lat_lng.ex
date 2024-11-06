defmodule ExPorterSDK.Structs.Types.AddressLatLng do
  @moduledoc """
  Geographic coordinates structure.
  """

  use TypedStruct

  alias ExPorterSDK.Protocols.Validatable
  alias ExPorterSDK.Protocols.Mappable
  alias ExPorterSDK.Protocols.Structable

  typedstruct enforce: true do
    field :lat, float()
    field :lng, float()
  end

  def validate(struct), do: Validatable.validate(struct)
  def to_map(struct), do: Mappable.to_map(struct)
  def from_map(map), do: Structable.from_map(map)
end
