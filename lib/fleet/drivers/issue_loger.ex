defmodule Fleet.Drivers.IssueLoger do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "tbl_vehicle_issue" do
    field :cost, :string
    field :problem_descript, :string
    field :dt_issued, :string
    field :dt_resolved, :string
    field :first_name, :string
    field :last_name, :string
    field :payment_doc, Fleet.FileUploader.Type
    field :phone, :string
    field :brand, :string
    field :name, :string
    field :plate_no, :string
    field :chassis_no, :string
    field :vendor, :string
    field :approval_status, :string, default: "PENDING"
    field :decline_reason, :string

    belongs_to :user, Fleet.Accounts.User, foreign_key: :driver_id, type: :id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(issue_loger, attrs) do
    issue_loger
    |> cast(attrs, [:payment_doc])
    |> cast_attachments(attrs, [:payment_doc])
    |> cast(attrs, [:first_name, :last_name, :chassis_no, :phone, :brand, :name, :plate_no, :problem_descript, :dt_issued, :dt_resolved, :vendor, :cost, :payment_doc, :approval_status, :decline_reason, :driver_id])
    # |> validate_required([:first_name, :last_name, :chassis_no, :phone, :brand, :name, :plate_no, :problem_descript, :dt_issued, :dt_resolved, :vendor, :cost, :payment_doc, :approval_status, :decline_reason, :driver_id])
  end
end
