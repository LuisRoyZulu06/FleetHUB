defmodule Fleet.Repo.Migrations.AlterTblVehicleIssue do
  use Ecto.Migration

  def change do
    alter table(:tbl_vehicle_issue) do
      add :approval_status, :string
      add :decline_reason, :string
    end
  end
end
