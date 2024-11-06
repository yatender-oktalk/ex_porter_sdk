defmodule ExPorterSDK.Structs.Types.ContactDetails do
  use TypedStruct

  alias ExPorterSDK.Protocols.Validatable
  alias ExPorterSDK.Protocols.Mappable
  alias ExPorterSDK.Protocols.Structable

  typedstruct do
    field :country_code, String.t(), enforce: true
    field :number, String.t()
  end

  def validate(struct), do: Validatable.validate(struct)
  def to_map(struct), do: Mappable.to_map(struct)
  def from_map(map), do: Structable.from_map(map)
end
