defmodule Fleet.Repo.Migrations.CreateTblUsers do
  use Ecto.Migration

  def change do
    create table(:tbl_users) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :password, :string
      add :user_type, :integer
      add :user_role, :string
      add :status, :integer
      add :user_id, :string
      add :auto_password, :string
      add :sex, :string
      add :age, :integer
      add :nrc_no, :string
      add :phone, :string
      add :home_add, :string
      add :dlt, :string
      add :dln, :string
      add :dl_exp_dt, :string

      timestamps()
    end
    create unique_index(:tbl_users, [:nrc_no], name: :unique_nrc_no)
    create unique_index(:tbl_users, [:phone], name: :unique_phone)
    create unique_index(:tbl_users, [:email], name: :unique_email)
    create unique_index(:tbl_users, [:dln], name: :unique_dln)
  end
end
