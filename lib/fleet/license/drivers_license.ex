defmodule Fleet.License.Drivers_license do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_license_type" do
    field :name, :string
    field :vehicle_cat, :string
    field :weight, :string

    timestamps()
  end

  @doc false
  def changeset(drivers_license, attrs) do
    drivers_license
    |> cast(attrs, [:name, :vehicle_cat, :weight])
    |> validate_required([:name, :vehicle_cat, :weight])
  end
end
