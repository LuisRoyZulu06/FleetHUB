defmodule Fleet.Problems do
  @moduledoc """
  The Problems context.
  """

  import Ecto.Query, warn: false
  alias Fleet.Repo

  alias Fleet.Problems.Vehicle_problem

  @doc """
  Returns the list of tbl_vehicle_problems.

  ## Examples

      iex> list_tbl_vehicle_problems()
      [%Vehicle_problem{}, ...]

  """
  def list_tbl_vehicle_problems do
    Repo.all(Vehicle_problem)
  end

  @doc """
  Gets a single vehicle_problem.

  Raises `Ecto.NoResultsError` if the Vehicle problem does not exist.

  ## Examples

      iex> get_vehicle_problem!(123)
      %Vehicle_problem{}

      iex> get_vehicle_problem!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vehicle_problem!(id), do: Repo.get!(Vehicle_problem, id)

  @doc """
  Creates a vehicle_problem.

  ## Examples

      iex> create_vehicle_problem(%{field: value})
      {:ok, %Vehicle_problem{}}

      iex> create_vehicle_problem(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vehicle_problem(attrs \\ %{}) do
    %Vehicle_problem{}
    |> Vehicle_problem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vehicle_problem.

  ## Examples

      iex> update_vehicle_problem(vehicle_problem, %{field: new_value})
      {:ok, %Vehicle_problem{}}

      iex> update_vehicle_problem(vehicle_problem, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vehicle_problem(%Vehicle_problem{} = vehicle_problem, attrs) do
    vehicle_problem
    |> Vehicle_problem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vehicle_problem.

  ## Examples

      iex> delete_vehicle_problem(vehicle_problem)
      {:ok, %Vehicle_problem{}}

      iex> delete_vehicle_problem(vehicle_problem)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vehicle_problem(%Vehicle_problem{} = vehicle_problem) do
    Repo.delete(vehicle_problem)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vehicle_problem changes.

  ## Examples

      iex> change_vehicle_problem(vehicle_problem)
      %Ecto.Changeset{source: %Vehicle_problem{}}

  """
  def change_vehicle_problem(%Vehicle_problem{} = vehicle_problem) do
    Vehicle_problem.changeset(vehicle_problem, %{})
  end
end
