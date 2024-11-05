defmodule ExPorterSDK.Structs.Types.CustomerDetails do
  use TypedStruct

  typedstruct do
    field :name, String.t(), enforce: true
    field :mobile, String.t()
  end
end
