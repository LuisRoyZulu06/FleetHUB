defmodule Fleet.Repo.Migrations.CreateTblVehicles do
  use Ecto.Migration

  def change do
    create table(:tbl_vehicles) do
      add :v_make, :string
      add :v_name, :string
      add :color, :string
      add :plate_no, :string
      add :v_status, :string
      add :mileage, :string
      add :rd_tax_exp_dt, :string
      add :fitness_exp_dt, :string
      add :insrnc_exp_dt, :string
      add :assigned_to, :string
      add :assignment_status, :string
      add :driver_id, references(:tbl_users, column: :id, on_delete: :delete_all)

      timestamps()
    end
    create unique_index(:tbl_vehicles, [:plate_no])

  end
end
