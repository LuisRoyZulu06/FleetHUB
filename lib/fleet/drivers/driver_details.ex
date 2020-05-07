defmodule Fleet.Drivers.DriverDetails do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_drivers" do
    field :age, :integer
    field :dl_exp_dt, :string
    field :dln, :string
    field :dlt, :string
    field :email, :string
    field :first_name, :string
    field :home_add, :string
    field :last_name, :string
    field :nrc_no, :string
    field :phone, :string
    field :sex, :string

    timestamps()
  end

  @doc false
  def changeset(driver_details, attrs) do
    driver_details
    |> cast(attrs, [:first_name, :last_name, :sex, :age, :nrc_no, :phone, :home_add, :email, :dlt, :dln, :dl_exp_dt])
    |> validate_required([:first_name, :last_name, :sex, :age, :nrc_no, :phone, :home_add, :email, :dlt, :dln, :dl_exp_dt])
    |> unique_constraint(:nrc_no, name: :unique_nrc_no, message: "Current record already exists!")
    |> unique_constraint(:phone, name: :unique_phone, message: "Current record already exists!")
    |> unique_constraint(:email, name: :unique_email, message: "Current record already exists!")
  end
end
