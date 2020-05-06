defmodule Fleet.Vehicles.VehicleDetails do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_vehicles" do
    field :assigned_to, :string
    field :assignment_status, :string, default: "not_assigned"
    field :color, :string
    field :fitness_exp_dt, :string
    field :insrnc_exp_dt, :string
    field :mileage, :string
    field :plate_no, :string
    field :rd_tax_exp_dt, :string
    field :v_make, :string
    field :v_name, :string
    field :v_status, :string

    timestamps()
  end

  @doc false
  def changeset(vehicle_details, attrs) do
    vehicle_details
    |> cast(attrs, [:v_make, :v_name, :color, :plate_no, :v_status, :mileage, :rd_tax_exp_dt, :fitness_exp_dt, :insrnc_exp_dt, :assigned_to, :assignment_status])
    |> validate_required([:v_make, :v_name, :color, :plate_no, :v_status, :mileage, :rd_tax_exp_dt, :fitness_exp_dt, :insrnc_exp_dt, :assigned_to, :assignment_status])
  end
end