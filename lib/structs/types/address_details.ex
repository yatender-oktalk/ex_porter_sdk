defmodule ExPorterSDK.Structs.Types.AddressDetails do
  @moduledoc """
  Represents the details of an address.
  """

  use TypedStruct

  alias ExPorterSDK.Structs.Types.ContactDetails

  typedstruct do
    field :apartmentAddress, String.t()
    field :streetAddress1, String.t()
    field :streetAddress2, String.t()
    field :landmark, String.t()
    field :city, String.t()
    field :state, String.t()
    field :pincode, String.t()
    field :country, String.t()
    field :lat, float(), enforce: true
    field :lng, float(), enforce: true
    field :contactDetails, ContactDetails.t(), enforce: true
  end
end
