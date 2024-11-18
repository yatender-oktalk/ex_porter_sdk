defmodule ExPorterSDK.Quote.Stub do
  @moduledoc """
  Stub implementation of Quote operations for testing.
  """

  @behaviour ExPorterSDK.Behaviours.Quote

  @impl true
  def get_quote(params) do
    {:ok,
     %{
       "vehicles" => [
         %{
           "capacity" => %{"unit" => "kg", "value" => 2500.0},
           "eta" => nil,
           "fare" => %{"currency" => "INR", "minor_amount" => 84621},
           "size" => %{
             "breadth" => %{"unit" => "ft", "value" => 5.5},
             "height" => %{"unit" => "ft", "value" => 6.0},
             "length" => %{"unit" => "ft", "value" => 9.0}
           },
           "type" => "Tata 407"
         },
         %{
           "capacity" => %{"unit" => "kg", "value" => 750.0},
           "eta" => nil,
           "fare" => %{"currency" => "INR", "minor_amount" => 54275},
           "size" => %{
             "breadth" => %{"unit" => "ft", "value" => 4.5},
             "height" => %{"unit" => "ft", "value" => 5.5},
             "length" => %{"unit" => "ft", "value" => 7.0}
           },
           "type" => "Ace (Helper + 1 Labour)"
         },
         %{
           "capacity" => %{"unit" => "kg", "value" => 500.0},
           "eta" => nil,
           "fare" => %{"currency" => "INR", "minor_amount" => 36697},
           "size" => %{
             "breadth" => %{"unit" => "ft", "value" => 5.0},
             "height" => %{"unit" => "ft", "value" => 5.0},
             "length" => %{"unit" => "ft", "value" => 6.0}
           },
           "type" => "3 Wheeler"
         },
         %{
           "capacity" => %{"unit" => "kg", "value" => 20.0},
           "eta" => nil,
           "fare" => %{"currency" => "INR", "minor_amount" => 8556},
           "size" => %{
             "breadth" => %{"unit" => "ft", "value" => 5.5},
             "height" => %{"unit" => "ft", "value" => 6.0},
             "length" => %{"unit" => "ft", "value" => 9.0}
           },
           "type" => "2 Wheeler"
         }
       ]
     }}
  end
end
