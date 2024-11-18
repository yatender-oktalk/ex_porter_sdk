defmodule ExPorterSDK.QuoteTest do
  use ExUnit.Case
  import Mox
  alias ExPorterSDK.Quote

  # Always verify mocks before test exits
  setup :verify_on_exit!

  @valid_params_atoms %{
    pickup_details: %{lat: 12.909728534457143, lng: 77.6001397394293},
    drop_details: %{lat: 12.89795704454522, lng: 77.62119799020186},
    customer: %{
      name: "Porter Test User",
      mobile: %{number: "7678139714", country_code: "+91"}
    }
  }

  @valid_params_strings %{
    "pickup_details" => %{"lat" => 12.909728534457143, "lng" => 77.6001397394293},
    "drop_details" => %{"lat" => 12.89795704454522, "lng" => 77.62119799020186},
    "customer" => %{
      "name" => "Porter Test User",
      "mobile" => %{"number" => "7678139714", "country_code" => "+91"}
    }
  }

  describe "data validation" do
    setup do
      # Allow the stub to pass through for validation tests
      ExPorterSDK.Quote.Stub
      |> stub(:get_quote, fn _params ->
        {:ok, %{"vehicles" => []}}
      end)

      :ok
    end

    test "validates params with atom keys" do
      assert {:ok, _response} = Quote.get_quote(@valid_params_atoms)
    end

    test "validates params with string keys" do
      assert {:ok, _response} = Quote.get_quote(@valid_params_strings)
    end

    test "invalid params - not a map" do
      assert {:error, "Invalid params: Expected a map"} = Quote.get_quote("not a map")
    end

    test "invalid params - missing required fields" do
      params = Map.delete(@valid_params_atoms, :pickup_details)
      assert {:error, "Invalid fare estimate: Address data is nil"} = Quote.get_quote(params)
    end

    test "invalid params - invalid latitude" do
      params = put_in(@valid_params_atoms, [:pickup_details, :lat], "invalid")

      assert {:error, "Invalid fare estimate: Invalid address: latitude must be a number"} =
               Quote.get_quote(params)
    end

    test "invalid params - latitude out of range" do
      params = put_in(@valid_params_atoms, [:pickup_details, :lat], 91.0)

      assert {:error, "Invalid fare estimate: Invalid address: latitude out of range"} =
               Quote.get_quote(params)
    end

    test "invalid params - invalid customer details" do
      params = put_in(@valid_params_atoms, [:customer, :mobile, :country_code], nil)

      assert {:error,
              "Invalid fare estimate: Invalid customer: Invalid contact: Country code must be a string"} =
               Quote.get_quote(params)
    end
  end

  describe "stub responses" do
    test "returns successful response with expected structure" do
      ExPorterSDK.Quote.Stub
      |> expect(:get_quote, fn _params ->
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
             }
           ]
         }}
      end)

      assert {:ok, response} = Quote.get_quote(@valid_params_atoms)
      assert_valid_response_structure(response)
    end

    test "handles error responses" do
      ExPorterSDK.Quote.Stub
      |> expect(:get_quote, fn _params ->
        {:error, %{status: 400, message: "Bad Request"}}
      end)

      assert {:error, %{status: 400}} = Quote.get_quote(@valid_params_atoms)
    end
  end

  # Helper function to verify response structure
  defp assert_valid_response_structure(response) do
    assert is_map(response)
    assert Map.has_key?(response, "vehicles")
    assert is_list(response["vehicles"])

    Enum.each(response["vehicles"], fn vehicle ->
      assert Map.has_key?(vehicle, "type")
      assert Map.has_key?(vehicle, "capacity")
      assert Map.has_key?(vehicle, "fare")
      assert Map.has_key?(vehicle, "size")

      assert vehicle["capacity"]["unit"] == "kg"
      assert is_number(vehicle["capacity"]["value"])

      assert vehicle["fare"]["currency"] == "INR"
      assert is_integer(vehicle["fare"]["minor_amount"])

      size = vehicle["size"]

      Enum.each(["length", "breadth", "height"], fn dimension ->
        assert size[dimension]["unit"] == "ft"
        assert is_number(size[dimension]["value"])
      end)
    end)
  end
end
