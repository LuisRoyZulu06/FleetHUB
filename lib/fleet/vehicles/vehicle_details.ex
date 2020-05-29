defmodule Fleet.Vehicles.VehicleDetails do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_vehicles" do
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
    # field :driver_id, :string

    belongs_to :vehicledetails, Fleet.Accounts.User, foreign_key: :driver_id, type: :id
    timestamps()
  end

  @doc false
  def changeset(vehicle_details, attrs) do
    vehicle_details
    |> cast(attrs, [:v_make, :v_name, :color, :plate_no, :v_status, :mileage, :rd_tax_exp_dt, :fitness_exp_dt, :insrnc_exp_dt, :assignment_status, :driver_id])
    # |> validate_required([:v_make, :v_name, :color, :plate_no, :v_status, :mileage, :rd_tax_exp_dt, :fitness_exp_dt, :insrnc_exp_dt, :assignment_status])
    # |> unique_constraint(:driver_id, name: :unique_driver_id, message: "Record with this user ID already exists!")
  end
end