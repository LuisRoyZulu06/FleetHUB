defmodule Fleet.Drivers do
  @moduledoc """
  The Drivers context.
  """

  import Ecto.Query, warn: false
  alias Fleet.Repo

  alias Fleet.Drivers.IssueLoger

  @doc """
  Returns the list of tbl_vehicle_issue.

  ## Examples

      iex> list_tbl_vehicle_issue()
      [%IssueLoger{}, ...]

  """
  def list_tbl_vehicle_issue do
    Repo.all(IssueLoger)
  end
  @doc """
  Gets a single issue_loger.

  Raises `Ecto.NoResultsError` if the Issue loger does not exist.

  ## Examples

      iex> get_issue_loger!(123)
      %IssueLoger{}

      iex> get_issue_loger!(456)
      ** (Ecto.NoResultsError)

  """
  def get_issue_loger!(id), do: Repo.get!(IssueLoger, id)

  @doc """
  Creates a issue_loger.

  ## Examples

      iex> create_issue_loger(%{field: value})
      {:ok, %IssueLoger{}}

      iex> create_issue_loger(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_issue_loger(attrs \\ %{}) do
    %IssueLoger{}
    |> IssueLoger.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a issue_loger.

  ## Examples

      iex> update_issue_loger(issue_loger, %{field: new_value})
      {:ok, %IssueLoger{}}

      iex> update_issue_loger(issue_loger, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_issue_loger(%IssueLoger{} = issue_loger, attrs) do
    issue_loger
    |> IssueLoger.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a issue_loger.

  ## Examples

      iex> delete_issue_loger(issue_loger)
      {:ok, %IssueLoger{}}

      iex> delete_issue_loger(issue_loger)
      {:error, %Ecto.Changeset{}}

  """
  def delete_issue_loger(%IssueLoger{} = issue_loger) do
    Repo.delete(issue_loger)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking issue_loger changes.

  ## Examples

      iex> change_issue_loger(issue_loger)
      %Ecto.Changeset{source: %IssueLoger{}}

  """
  def change_issue_loger(%IssueLoger{} = issue_loger) do
    IssueLoger.changeset(issue_loger, %{})
  end
end
