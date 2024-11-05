defmodule ExPorterSDK.Structs.Types.ContactDetails do
  use TypedStruct

  typedstruct do
    field :country_code, String.t(), enforce: true
    field :number, String.t()
  end
end
