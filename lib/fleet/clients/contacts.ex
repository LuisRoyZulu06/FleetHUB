defmodule Fleet.Clients.Contacts do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_vendors" do
    field :comp_address, :string
    field :comp_email, :string
    field :comp_info, :string
    field :comp_name, :string
    field :comp_tel, :string
    field :email, :string
    field :position, :string
    field :rep_name, :string

    timestamps()
  end

  @doc false
  def changeset(contacts, attrs) do
    contacts
    |> cast(attrs, [:rep_name, :position, :email, :comp_name, :comp_email, :comp_tel, :comp_address, :comp_info])
    |> validate_required([:rep_name, :position, :email, :comp_name, :comp_email, :comp_tel, :comp_address, :comp_info])
  end
end
