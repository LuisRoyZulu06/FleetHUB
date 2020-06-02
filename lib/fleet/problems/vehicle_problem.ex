defmodule Fleet.Problems.Vehicle_problem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_vehicle_problems" do
    field :problem_descr, :string

    timestamps()
  end

  @doc false
  def changeset(vehicle_problem, attrs) do
    vehicle_problem
    |> cast(attrs, [:problem_descr])
    |> validate_required([:problem_descr])
  end
end
