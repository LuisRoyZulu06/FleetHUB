defmodule Fleet.License do
  @moduledoc """
  The License context.
  """

  import Ecto.Query, warn: false
  alias Fleet.Repo

  alias Fleet.License.Drivers_license

  @doc """
  Returns the list of tbl_license_type.

  ## Examples

      iex> list_tbl_license_type()
      [%Drivers_license{}, ...]

  """
  def list_tbl_license_type do
    Repo.all(Drivers_license)
  end

  @doc """
  Gets a single drivers_license.

  Raises `Ecto.NoResultsError` if the Drivers license does not exist.

  ## Examples

      iex> get_drivers_license!(123)
      %Drivers_license{}

      iex> get_drivers_license!(456)
      ** (Ecto.NoResultsError)

  """
  def get_drivers_license!(id), do: Repo.get!(Drivers_license, id)

  @doc """
  Creates a drivers_license.

  ## Examples

      iex> create_drivers_license(%{field: value})
      {:ok, %Drivers_license{}}

      iex> create_drivers_license(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_drivers_license(attrs \\ %{}) do
    %Drivers_license{}
    |> Drivers_license.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a drivers_license.

  ## Examples

      iex> update_drivers_license(drivers_license, %{field: new_value})
      {:ok, %Drivers_license{}}

      iex> update_drivers_license(drivers_license, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_drivers_license(%Drivers_license{} = drivers_license, attrs) do
    drivers_license
    |> Drivers_license.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a drivers_license.

  ## Examples

      iex> delete_drivers_license(drivers_license)
      {:ok, %Drivers_license{}}

      iex> delete_drivers_license(drivers_license)
      {:error, %Ecto.Changeset{}}

  """
  def delete_drivers_license(%Drivers_license{} = drivers_license) do
    Repo.delete(drivers_license)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking drivers_license changes.

  ## Examples

      iex> change_drivers_license(drivers_license)
      %Ecto.Changeset{source: %Drivers_license{}}

  """
  def change_drivers_license(%Drivers_license{} = drivers_license) do
    Drivers_license.changeset(drivers_license, %{})
  end
end
