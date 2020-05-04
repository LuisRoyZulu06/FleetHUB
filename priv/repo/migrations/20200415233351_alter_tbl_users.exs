defmodule Fleet.Repo.Migrations.AlterTblUsers do
  use Ecto.Migration

  def change do
    alter table(:tbl_users) do
      add :auto_password, :string
    end
  end
end
