defmodule ExPorterSDK.OrderTest do
  use ExUnit.Case
  import Mox
  alias ExPorterSDK.Order

  setup :verify_on_exit!

  @valid_create_params %{
    request_id: "86098bfc-87e0-11ec-a8a3-0242ac120005",
    delivery_instructions: %{
      instructions_list: [
        %{
          type: "text",
          description: "handle with care"
        },
        %{
          type: "text",
          description: "Test order 52"
        }
      ]
    },
    pickup_details: %{
      address: %{
        apartment_address: "27",
        street_address1: "Sona Towers",
        street_address2: "Krishna Nagar Industrial Area",
        landmark: "Hosur Road",
        city: "Bengaluru",
        state: "Karnataka",
        pincode: "560029",
        country: "India",
        lat: 12.939391726766775,
        lng: 77.62629462844717,
        contact_details: %{
          name: "Porter Test User",
          phone_number: "+911234567890"
        }
      }
    },
    drop_details: %{
      address: %{
        apartment_address: "this is apartment address",
        street_address1: "BTM Layout",
        street_address2: "Another street address",
        landmark: "BTM Layout",
        city: "Bengaluru",
        state: "Karnataka",
        pincode: "560029",
        country: "India",
        lat: 12.9165757,
        lng: 77.6101163,
        contact_details: %{
          name: "Porter Test User",
          phone_number: "+911234567890"
        }
      }
    }
  }

  @valid_order_id "CRN1732081876717"

  describe "concrete stub implementation" do
    test "creates order successfully" do
      assert {:ok, response} = Order.create(@valid_create_params)
      assert_valid_create_response(response)
    end

    test "tracks order successfully" do
      assert {:ok, response} = Order.track(@valid_order_id)
      assert_valid_track_response(response)
    end

    test "cancels order successfully" do
      assert {:ok, response} = Order.cancel(@valid_order_id)
      assert_valid_cancel_response(response)
    end
  end

  describe "error scenarios with mock" do
    setup do
      previous_impl = Application.get_env(:ex_porter_sdk, :order_impl)
      Application.put_env(:ex_porter_sdk, :order_impl, ExPorterSDK.MockOrder)

      on_exit(fn ->
        Application.put_env(:ex_porter_sdk, :order_impl, previous_impl)
      end)

      :ok
    end

    test "handles invalid create params" do
      ExPorterSDK.MockOrder
      |> expect(:create, fn _params ->
        {:error, %{status: 400, message: "Invalid parameters"}}
      end)

      invalid_params = Map.delete(@valid_create_params, :pickup_details)
      assert {:error, %{status: 400}} = Order.create(invalid_params)
    end

    test "handles non-existent order tracking" do
      ExPorterSDK.MockOrder
      |> expect(:track, fn "non_existent" ->
        {:error, %{status: 404, message: "Order not found"}}
      end)

      assert {:error, %{status: 404}} = Order.track("non_existent")
    end
  end

  # Helper functions for validation
  defp assert_valid_create_response(response) do
    assert is_map(response)
    assert is_binary(response["order_id"])
    assert response["status"] in ["created", "accepted"]

    assert response["estimated_price"]["currency"] == "INR"
    assert is_integer(response["estimated_price"]["minor_amount"])

    assert is_integer(response["pickup_eta"])
  end

  defp assert_valid_track_response(response) do
    assert is_map(response)
    assert is_binary(response["order_id"])
    assert response["status"] in ["created", "accepted", "in_progress", "completed", "cancelled"]

    assert is_map(response["fare_details"])
    assert is_map(response["order_timings"])

    timings = response["order_timings"]
    assert is_integer(timings["order_accepted_time"]) || is_nil(timings["order_accepted_time"])
    assert is_integer(timings["pickup_time"]) || is_nil(timings["pickup_time"])
  end

  defp assert_valid_cancel_response(response) do
    assert is_map(response)
    assert response["code"] == 200
    assert is_binary(response["message"])
  end
end
