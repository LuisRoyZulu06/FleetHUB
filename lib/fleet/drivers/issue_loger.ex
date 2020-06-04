defmodule Fleet.Drivers.IssueLoger do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "tbl_vehicle_issue" do
    field :cost, :string
    field :descr_fxd_problem, :string
    field :dt_issued, :string
    field :dt_resolved, :string
    field :first_name, :string
    field :last_name, :string
    field :payment_doc, Fleet.FileUploader.Type
    field :phone, :string
    field :slct_fxd_problem, :string
    field :v_descr_problem, :string
    field :v_make, :string
    field :v_name, :string
    field :v_plate_no, :string
    field :v_slct_problem, :string
    field :v_status, :string
    field :vendor, :string
    field :approval_status, :string, default: "pending"
    field :decline_reason, :string

    belongs_to :user, Fleet.Accounts.User, foreign_key: :driver_id, type: :id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(issue_loger, attrs) do
    issue_loger
    |> cast(attrs, [:payment_doc])
    |> cast_attachments(attrs, [:payment_doc])
    |> cast(attrs, [:first_name, :last_name, :phone, :v_make, :v_name, :v_plate_no, :v_descr_problem, :v_slct_problem, :slct_fxd_problem, :descr_fxd_problem, :dt_issued, :dt_resolved, :vendor, :cost, :payment_doc, :v_status, :approval_status, :decline_reason, :driver_id])
    # |> validate_required([:first_name, :last_name, :phone, :v_make, :v_name, :v_plate_no, :v_descr_problem, :v_slct_problem, :slct_fxd_problem, :descr_fxd_problem, :dt_issued, :dt_resolved, :vendor, :cost, :payment_doc, :v_status, :approval_status, :decline_reason])
  end
end
