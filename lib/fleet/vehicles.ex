defmodule Fleet.Vehicles do
  @moduledoc """
  The Vehicles context.
  """

  import Ecto.Query, warn: false
  alias Fleet.Repo

  alias Fleet.Vehicles.VehicleDetails

  @doc """
  Returns the list of tbl_vehicles.

  ## Examples

      iex> list_tbl_vehicles()
      [%VehicleDetails{}, ...]

  """
  def list_tbl_vehicles do
    Repo.all(VehicleDetails)
  end

  @doc """
  Gets a single vehicle_details.

  Raises `Ecto.NoResultsError` if the Vehicle details does not exist.

  ## Examples

      iex> get_vehicle_details!(123)
      %VehicleDetails{}

      iex> get_vehicle_details!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vehicle_details!(id), do: Repo.get!(VehicleDetails, id)

  @doc """
  Creates a vehicle_details.

  ## Examples

      iex> create_vehicle_details(%{field: value})
      {:ok, %VehicleDetails{}}

      iex> create_vehicle_details(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vehicle_details(attrs \\ %{}) do
    %VehicleDetails{}
    |> VehicleDetails.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vehicle_details.

  ## Examples

      iex> update_vehicle_details(vehicle_details, %{field: new_value})
      {:ok, %VehicleDetails{}}

      iex> update_vehicle_details(vehicle_details, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vehicle_details(%VehicleDetails{} = vehicle_details, attrs) do
    vehicle_details
    |> VehicleDetails.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vehicle_details.

  ## Examples

      iex> delete_vehicle_details(vehicle_details)
      {:ok, %VehicleDetails{}}

      iex> delete_vehicle_details(vehicle_details)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vehicle_details(%VehicleDetails{} = vehicle_details) do
    Repo.delete(vehicle_details)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vehicle_details changes.

  ## Examples

      iex> change_vehicle_details(vehicle_details)
      %Ecto.Changeset{source: %VehicleDetails{}}

  """
  def change_vehicle_details(%VehicleDetails{} = vehicle_details) do
    VehicleDetails.changeset(vehicle_details, %{})
  end
end
