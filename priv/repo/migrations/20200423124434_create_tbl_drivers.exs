defmodule Fleet.Repo.Migrations.CreateTblDrivers do
  use Ecto.Migration

  def change do
    create table(:tbl_drivers) do
      add :first_name, :string
      add :last_name, :string
      add :sex, :string
      add :age, :integer
      add :nrc_no, :string
      add :phone, :string
      add :home_add, :string
      add :email, :string
      add :dlt, :string
      add :dln, :string
      add :dl_exp_dt, :string

      timestamps()
    end

  end
end
