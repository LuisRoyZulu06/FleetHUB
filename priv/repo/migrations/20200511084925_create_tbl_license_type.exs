defmodule Fleet.Repo.Migrations.CreateTblLicenseType do
  use Ecto.Migration

  def change do
    create table(:tbl_license_type) do
      add :name, :string
      add :vehicle_cat, :string
      add :weight, :string

      timestamps()
    end

  end
end
