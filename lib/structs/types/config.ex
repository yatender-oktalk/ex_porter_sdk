defmodule ExPorterSDK.Structs.Types.Config do
  @moduledoc """
  Configuration struct for Porter SDK.
  """

  use TypedStruct

  alias ExPorterSDK.Protocols.Validatable
  alias ExPorterSDK.Protocols.Mappable

  typedstruct do
    field :api_key, String.t(), enforce: true
    field :environment, atom(), default: :dev
    field :webhook_secret, String.t()
  end

  def validate(struct), do: Validatable.validate(struct)
  def to_map(struct), do: Mappable.to_map(struct)
end
