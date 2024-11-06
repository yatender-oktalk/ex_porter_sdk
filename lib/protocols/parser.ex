defmodule Parser do
  @moduledoc """
  Provides functions to parse fare estimate data, customer details, contact details, and addresses.
  """

  @doc """
  Parses fare estimate data from a map.

  ## Parameters
    - map: A map containing fare estimate data or nil.

  ## Returns
    - `FareEstimateRequest.t()` on success.
    - `{:error, String.t()}` on failure with an error message.
  """
  @spec parse_fare_estimate(map() | nil) :: FareEstimateRequest.t() | {:error, String.t()}
  def parse_fare_estimate(nil), do: {:error, "Fare estimate data is nil"}
  def parse_fare_estimate(map) when not is_map(map), do: {:error, "Invalid fare estimate format"}

  def parse_fare_estimate(map) do
    with {:ok, pickup} <- parse_address(map["pickup_details"]),
         {:ok, drop} <- parse_address(map["drop_details"]),
         {:ok, customer} <- parse_customer(map["customer"]) do
      %FareEstimateRequest{
        pickup_details: pickup,
        drop_details: drop,
        customer: customer
      }
    else
      {:error, reason} -> {:error, "Invalid fare estimate: #{reason}"}
    end
  end

  @doc """
  Parses customer details from a map.

  ## Parameters
    - map: A map containing customer details or nil.

  ## Returns
    - `{:ok, CustomerDetails.t()}` on success.
    - `{:error, String.t()}` on failure with an error message.
  """
  @spec parse_customer(map() | nil) :: {:ok, CustomerDetails.t()} | {:error, String.t()}
  def parse_customer(nil), do: {:error, "Customer data is nil"}
  def parse_customer(map) when not is_map(map), do: {:error, "Invalid customer format"}

  def parse_customer(map) do
    with {:ok, mobile} <- parse_contact(map["mobile"]),
         true <- is_binary(map["name"]) || {:error, "Name must be a string"},
         false <- String.trim(map["name"]) == "" || {:error, "Name cannot be empty"} do
      {:ok,
       %CustomerDetails{
         mobile: mobile,
         name: map["name"]
       }}
    else
      {:error, reason} -> {:error, "Invalid customer: #{reason}"}
      false -> {:error, "Invalid customer: Name is required"}
    end
  end

  @doc """
  Parses contact details from a map.

  ## Parameters
    - map: A map containing contact details or nil.

  ## Returns
    - `{:ok, ContactDetails.t()}` on success.
    - `{:error, String.t()}` on failure with an error message.
  """
  @spec parse_contact(map() | nil) :: {:ok, ContactDetails.t()} | {:error, String.t()}
  def parse_contact(nil), do: {:error, "Contact data is nil"}
  def parse_contact(map) when not is_map(map), do: {:error, "Invalid contact format"}

  def parse_contact(map) do
    with true <- is_binary(map["country_code"]) || {:error, "Country code must be a string"},
         true <- is_binary(map["number"]) || {:error, "Number must be a string"},
         false <-
           String.trim(map["country_code"]) == "" || {:error, "Country code cannot be empty"},
         false <- String.trim(map["number"]) == "" || {:error, "Number cannot be empty"} do
      {:ok,
       %ContactDetails{
         country_code: map["country_code"],
         number: map["number"]
       }}
    else
      {:error, reason} -> {:error, "Invalid contact: #{reason}"}
      false -> {:error, "Invalid contact: Required fields missing"}
    end
  end

  @doc """
  Parses address details from a map.

  ## Parameters
    - map: A map containing address details or nil.

  ## Returns
    - `{:ok, AddressLatLng.t()}` on success.
    - `{:error, String.t()}` on failure with an error message.
  """
  @spec parse_address(map() | nil) :: {:ok, AddressLatLng.t()} | {:error, String.t()}
  def parse_address(nil), do: {:error, "Address data is nil"}
  def parse_address(map) when not is_map(map), do: {:error, "Invalid address format"}

  def parse_address(map) do
    with {:ok, lat} <- validate_coordinate(map["lat"], "latitude"),
         {:ok, lng} <- validate_coordinate(map["lng"], "longitude") do
      {:ok,
       %AddressLatLng{
         lat: lat,
         lng: lng
       }}
    else
      {:error, reason} -> {:error, "Invalid address: #{reason}"}
    end
  end

  @doc """
  Validates a coordinate value.

  ## Parameters
    - value: The coordinate value to validate.
    - coord_type: The type of coordinate ("latitude" or "longitude").

  ## Returns
    - `{:ok, float()}` if the coordinate is valid.
    - `{:error, String.t()}` if the coordinate is invalid.
  """
  @spec validate_coordinate(any(), String.t()) :: {:ok, float()} | {:error, String.t()}
  defp validate_coordinate(value, coord_type) when is_number(value) do
    cond do
      coord_type == "latitude" and value >= -90 and value <= 90 ->
        {:ok, value}

        defp deps do
          [
            {:typed_struct, "~> 0.1.4"},
            {:req, "~> 0.5.7"},
            {:jason, "~> 1.4.0"},
            {:ex_doc, "~> 0.34", only: :dev, runtime: false}
          ]
        end

      coord_type == "longitude" and value >= -180 and value <= 180 ->
        {:ok, value}

      true ->
        {:error, "#{coord_type} out of range"}
    end
  end

  defp validate_coordinate(_, coord_type), do: {:error, "#{coord_type} must be a number"}
end
