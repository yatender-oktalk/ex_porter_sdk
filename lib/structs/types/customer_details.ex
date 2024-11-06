defmodule ExPorterSDK.Structs.Types.CustomerDetails do
  use TypedStruct

  alias ExPorterSDK.Protocols.Mappable
  alias ExPorterSDK.Protocols.Validatable
  alias ExPorterSDK.Protocols.Structable

  alias ExPorterSDK.Structs.Types.ContactDetails

  typedstruct do
    field :name, String.t(), enforce: true
    field :mobile, ContactDetails.t(), enforce: true
  end

  def validate(struct), do: Validatable.validate(struct)
  def to_map(struct), do: Mappable.to_map(struct)
  def from_map(map), do: Structable.from_map(map)
end
