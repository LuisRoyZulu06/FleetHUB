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
  # def list_tbl_vehicles do
  #   Repo.all(VehicleDetails)
  # end

  def list_tbl_vehicles do
    veh=Repo.all(VehicleDetails)
    comb=Repo.preload(veh, :vehicledetails)
  end


  def get_by_user_id(id) do
    Repo.get_by(VehicleDetails, driver_id: id)
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

  def dashboard_params do
    VehicleDetails

    # |> join(
    #   :right,
    #   [c],
    #   day in fragment("select generate_series(date_trunc('month',now()),
    #   date_trunc('MONTH', now()) + INTERVAL '1 MONTH - 1 day', '1 day')::date AS d"),
    #   day.d == fragment("date(?)", c.inserted_at)
    # )
    # |> group_by([c, day], [day.d, c.assignment_status])
    # |> order_by([_c, day], day.d)
    # |> select([c, day], %{
    #     day: fragment("to_char(?, 'YYYY-MM-DD')", day.d),
    #     count: count(c.id),
    #     status: fragment("""
    #     CASE
    #         WHEN ? = '1'
    #             THEN 'assigned'
    #         ELSE 'not_assigned'
    #     END
    #     """, c.assignment_status
    #     )
    #     })
    |> Repo.all()
  end

  def vehicles_assigned do
    query =
    """
    SELECT COUNT(tbl_users.id)
    FROM tbl_users
    INNER JOIN tbl_vehicles ON tbl_users.id = tbl_vehicles.driver_id;
    """
    {:ok, %{columns: columns, rows: rows}} = Repo.query(query, [])
    rows |> Enum.map(&Enum.zip(columns, &1)) |> Enum.map(&Enum.into(&1, %{}))
  end

  def total_vehicles do
    # query =
    # """
    # SELECT COUNT(id)
    # FROM tbl_vehicles;
    # """
    # {:ok, %{columns: columns, rows: rows}} = Repo.query(query, [])
    # rows |> Enum.map(&Enum.zip(columns, &1)) |> Enum.map(&Enum.into(&1, %{}))
    Repo.aggregate(from(v in "tbl_vehicles"), :count, :id)
  end

  def total_drivers do
    # query =
    # """
    # SELECT COUNT(id)
    # FROM tbl_users WHERE user_role = 'driver'
    # """
    # {:ok, %{columns: columns, rows: rows}} = Repo.query(query, [])
    # rows |> Enum.map(&Enum.zip(columns, &1)) |> Enum.map(&Enum.into(&1, %{}))
    Repo.aggregate(from(v in "tbl_users", where: v.user_role == "driver"), :count, :id)
  end

  def vehicles_unassigned do
    query =
    """
    SELECT COUNT(id)
    FROM tbl_vehicles WHERE assignment_status = '0';
    """
    {:ok, %{columns: columns, rows: rows}} = Repo.query(query, [])
    rows |> Enum.map(&Enum.zip(columns, &1)) |> Enum.map(&Enum.into(&1, %{}))
  end

  def vehicles_in_maintenance do
    query =
    """
    SELECT COUNT(id)
    FROM tbl_vehicle_issue WHERE v_status = 'garage';
    """
    {:ok, %{columns: columns, rows: rows}} = Repo.query(query, [])
    rows |> Enum.map(&Enum.zip(columns, &1)) |> Enum.map(&Enum.into(&1, %{}))
  end
end
