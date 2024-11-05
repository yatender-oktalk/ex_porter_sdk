defmodule ExPorterSDK.Structs.Types.Config do
  @moduledoc """
  Configuration struct for Porter SDK.
  """

  use TypedStruct

  typedstruct do
    field :api_key, String.t(), enforce: true
    field :environment, atom(), default: :dev
    field :webhook_secret, String.t()
  end
end
