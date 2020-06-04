defmodule Fleet.Repo.Migrations.CreateTblVehicleIssue do
  use Ecto.Migration

  def change do
    create table(:tbl_vehicle_issue) do
      add :first_name, :string
      add :last_name, :string
      add :phone, :string
      add :v_make, :string
      add :v_name, :string
      add :v_plate_no, :string
      add :v_descr_problem, :string
      add :v_slct_problem, :string
      add :slct_fxd_problem, :string
      add :descr_fxd_problem, :string
      add :dt_issued, :string
      add :dt_resolved, :string
      add :vendor, :string
      add :cost, :string
      add :payment_doc, :string
      add :v_status, :string
      add :approval_status, :string
      add :decline_reason, :string
      add :driver_id, references(:tbl_users, column: :id, on_delete: :delete_all)

      timestamps()
    end

  end
end
