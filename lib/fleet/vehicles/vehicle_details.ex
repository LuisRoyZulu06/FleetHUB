defmodule Fleet.Vehicles.VehicleDetails do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_vehicles" do
    field :assignment_status, :string, default: "0"
    field :ext_color, :string
    field :fitness_exp_dt, :string
    field :insrnc_exp_dt, :string
    field :mileage, :string
    field :plate_no, :string
    field :rd_tax_exp_dt, :string
    field :brand, :string
    field :v_name, :string
    field :v_type, :string
    field :chassis_no, :string
    field :man_year, :string

    belongs_to :vehicledetails, Fleet.Accounts.User, foreign_key: :driver_id, type: :id
    timestamps()
  end

  @doc false
  def changeset(vehicle_details, attrs) do
    vehicle_details
    |> cast(attrs, [:brand, :v_name, :ext_color, :plate_no, :mileage, :rd_tax_exp_dt, :fitness_exp_dt, :insrnc_exp_dt, :assignment_status, :driver_id, :man_year, :v_type, :chassis_no])
    # |> validate_required([:brand, :v_name, :ext_color, :plate_no, :mileage, :rd_tax_exp_dt, :fitness_exp_dt, :insrnc_exp_dt, :assignment_status, :driver_id, :man_year, :v_type, :chassis_no])
    # |> unique_constraint(:driver_id, name: :unique_driver_id, message: "Record with this user ID already exists!")
  end
end
