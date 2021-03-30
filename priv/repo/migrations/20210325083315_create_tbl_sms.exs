defmodule Fleet.Repo.Migrations.CreateTblSms do
  use Ecto.Migration

  def change do
    create table(:tbl_sms) do
      add :type, :string
      add :mobile, :string
      add :msg, :string
      add :status, :string
      add :msg_count, :string
      add :date_sent, :naive_datetime

      timestamps()
    end

  end
end
