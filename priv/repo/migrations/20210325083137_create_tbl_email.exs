defmodule Fleet.Repo.Migrations.CreateTblEmail do
  use Ecto.Migration

  def change do
    create table(:tbl_email) do
      add :attempts, :string
      add :mail_body, :string
      add :recipient_email, :string
      add :sender_email, :string
      add :status, :string
      add :subject, :string

      timestamps()
    end

  end
end
