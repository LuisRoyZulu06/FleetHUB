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

      timestamps()
    end
    create unique_index(:tbl_users, [:email])

  end
end
