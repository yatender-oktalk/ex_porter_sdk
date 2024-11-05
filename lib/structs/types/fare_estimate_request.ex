defmodule ExPorterSDK.Structs.Types.FareEstimateRequest do
  use TypedStruct

  typedstruct do
    field :pickup_details, AddressLatLng.t(), enforce: true
    field :drop_details, AddressLatLng.t(), enforce: true
    field :customer, CustomerDetails.t(), enforce: true
  end
end
