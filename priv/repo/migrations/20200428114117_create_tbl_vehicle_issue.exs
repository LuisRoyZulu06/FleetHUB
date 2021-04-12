defmodule Fleet.Repo.Migrations.CreateTblVehicleIssue do
  use Ecto.Migration

  def change do
    create table(:tbl_vehicle_issue) do
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :brand, :string
      add :name, :string
      add :plate_no, :string
      add :problem_descript, :string
      add :dt_issued, :string
      add :dt_resolved, :string
      add :vendor, :string
      add :cost, :string
      add :payment_doc, :string
      add :approval_status, :string
      add :decline_reason, :string
      add :chassis_no, :string
      add :driver_id, references(:tbl_users, column: :id, on_delete: :delete_all)

      timestamps()
    end

  end
end
