defmodule Fleet.Repo.Migrations.AlterTblVehicles do
  use Ecto.Migration

  def change do
    alter table(:tbl_vehicles) do
      add :user_id, :string
    end
  end
end
