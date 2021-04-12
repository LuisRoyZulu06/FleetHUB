defmodule Fleet.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Fleet.Repo

  alias Fleet.Accounts.User
  alias Fleet.Vehicles.VehicleDetails

  @doc """
  Returns the list of tbl_users.

  ## Examples

      iex> list_tbl_users()
      [%User{}, ...]

  """
  def list_tbl_users do
    Repo.all(User)
  end

  def get_by_vehicle_id(id) do
    Repo.get_by(VehicleDetails, driver_id: id)
  end

  def get_user_details(id) do
    Repo.get!(User, id)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)


  def get_vehicle_details(id) do
    # id = String.to_integer(id)
    User
    |> join(:left, [c], t in "tbl_vehicles", on: c.id == t.driver_id)
    |> where([c, t], t.driver_id == ^id)
    |> select([c, t], %{
      id: c.id,
      brand: t.brand,
      name: t.v_name,
      plate_no: t.plate_no,
      chassis_no: t.chassis_no
    })
    |> Repo.one()
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def get_user_by_email(email) do
    Repo.all(
      from(
        u in User,
        where: fragment("lower(?) = lower(?)", u.email, ^email),
        limit: 1,
        select: u
      )
    )
    |> case do
      [] ->
        nil

      user ->
        user
    end
  end
end
