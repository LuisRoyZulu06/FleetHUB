defmodule Fleet.Notifications.Sms do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_sms" do
    field :date_sent, :string
    field :mobile, :string
    field :msg_count, :string, default: "0"
    field :msg, :string
    field :status, :string, default: "READY"
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(sms, attrs) do
    sms
    |> cast(attrs, [:type, :mobile, :msg, :status, :msg_count, :date_sent])
    |> validate_required([:type, :mobile, :msg])
  end
end
