defmodule ExPorterSDK.Structs.Types.AddressLatLng do
  @moduledoc """
  Geographic coordinates structure.
  """

  use TypedStruct

  typedstruct enforce: true do
    field :lat, float()
    field :lng, float()
  end

  def validate(struct), do: ExPorterSDK.Protocols.Validatable.validate(struct)
  def to_map(struct), do: ExPorterSDK.Protocols.Mappable.to_map(struct)
end
