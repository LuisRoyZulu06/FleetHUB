defmodule Fleet.Repo.Migrations.CreateTblVendors do
  use Ecto.Migration

  def change do
    create table(:tbl_vendors) do
      add :rep_name, :string
      add :position, :string
      add :email, :string
      add :comp_name, :string
      add :comp_email, :string
      add :comp_tel, :string
      add :comp_address, :string
      add :comp_info, :string

      timestamps()
    end

  end
end
