defmodule ExPorterSDK.Structs.Types.CreateOrderRequest do
  @moduledoc """
  Represents a request to create an order.
  """

  use TypedStruct

  typedstruct do
    field :requestId, String.t(), enforce: true
    field :pickupDetails, Address.t(), enforce: true
    field :dropDetails, Address.t(), enforce: true
    field :additionalComments, String.t() | nil
  end
end
