defmodule Fleet.Clients do
  @moduledoc """
  The Clients context.
  """

  import Ecto.Query, warn: false
  alias Fleet.Repo

  alias Fleet.Clients.Contacts

  @doc """
  Returns the list of tbl_vendors.

  ## Examples

      iex> list_tbl_vendors()
      [%Contacts{}, ...]

  """
  def list_tbl_vendors do
    Repo.all(Contacts)
  end

  @doc """
  Gets a single contacts.

  Raises `Ecto.NoResultsError` if the Contacts does not exist.

  ## Examples

      iex> get_contacts!(123)
      %Contacts{}

      iex> get_contacts!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contacts!(id), do: Repo.get!(Contacts, id)

  @doc """
  Creates a contacts.

  ## Examples

      iex> create_contacts(%{field: value})
      {:ok, %Contacts{}}

      iex> create_contacts(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contacts(attrs \\ %{}) do
    %Contacts{}
    |> Contacts.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contacts.

  ## Examples

      iex> update_contacts(contacts, %{field: new_value})
      {:ok, %Contacts{}}

      iex> update_contacts(contacts, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contacts(%Contacts{} = contacts, attrs) do
    contacts
    |> Contacts.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a contacts.

  ## Examples

      iex> delete_contacts(contacts)
      {:ok, %Contacts{}}

      iex> delete_contacts(contacts)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contacts(%Contacts{} = contacts) do
    Repo.delete(contacts)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contacts changes.

  ## Examples

      iex> change_contacts(contacts)
      %Ecto.Changeset{source: %Contacts{}}

  """
  def change_contacts(%Contacts{} = contacts) do
    Contacts.changeset(contacts, %{})
  end
end
