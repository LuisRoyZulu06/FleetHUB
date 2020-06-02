defmodule Fleet.Repo.Migrations.CreateTblVehicleProblems do
  use Ecto.Migration

  def change do
    create table(:tbl_vehicle_problems) do
      add :problem_descr, :string

      timestamps()
    end

  end
end
