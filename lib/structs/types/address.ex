defmodule ExPorterSDK.Structs.Types.Address do
  @moduledoc """
  Represents an address.
  """

  use TypedStruct

  alias ExPorterSDK.Structs.Types.AddressDetails

  typedstruct do
    field :address, AddressDetails.t(), enforce: true
  end
end
