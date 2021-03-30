defmodule Fleet.Repo.Migrations.CreateTblUsers do
  use Ecto.Migration

  def change do
    create table(:tbl_users) do
      add :auto_password, :string, default: "Y"
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :password, :string
      add :account_status, :string
      add :user_role, :string
      add :user_type, :integer
      add :id_type, :string
      add :nrc_no, :string
      add :drvrs_license_exp_dt, :string
      add :drvrs_license_no, :string
      add :drvrs_license_class, :string
      add :phone, :string
      add :sex, :string
      add :acc_deactive_reason, :string

      timestamps()
    end
    create unique_index(:tbl_users, [:drvrs_license_no], name: :unique_drvrs_license_no)
    create unique_index(:tbl_users, [:nrc_no], name: :unique_nrc)
    create unique_index(:tbl_users, [:phone], name: :unique_phone)
    create unique_index(:tbl_users, [:email], name: :unique_email)
  end
end
