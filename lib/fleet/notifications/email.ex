defmodule Fleet.Notifications.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_email" do
    field :attempts, :string, default: "0"
    field :mail_body, :string
    field :recipient_email, :string
    field :sender_email, :string
    field :status, :string, default: "READY"
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:attempts, :mail_body, :recipient_email, :sender_email, :status, :subject])
    # |> validate_required([:attempts, :mail_body, :recipient_email, :sender_email, :status, :subject])
  end
end
