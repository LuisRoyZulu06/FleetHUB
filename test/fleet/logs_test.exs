defmodule Fleet.LogsTest do
  use Fleet.DataCase

  alias Fleet.Logs

  describe "tbl_user_logs" do
    alias Fleet.Logs.User_Logs

    @valid_attrs %{activity: "some activity", user_id: "some user_id"}
    @update_attrs %{activity: "some updated activity", user_id: "some updated user_id"}
    @invalid_attrs %{activity: nil, user_id: nil}

    def user__logs_fixture(attrs \\ %{}) do
      {:ok, user__logs} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logs.create_user__logs()

      user__logs
    end

    test "list_tbl_user_logs/0 returns all tbl_user_logs" do
      user__logs = user__logs_fixture()
      assert Logs.list_tbl_user_logs() == [user__logs]
    end

    test "get_user__logs!/1 returns the user__logs with given id" do
      user__logs = user__logs_fixture()
      assert Logs.get_user__logs!(user__logs.id) == user__logs
    end

    test "create_user__logs/1 with valid data creates a user__logs" do
      assert {:ok, %User_Logs{} = user__logs} = Logs.create_user__logs(@valid_attrs)
      assert user__logs.activity == "some activity"
      assert user__logs.user_id == "some user_id"
    end

    test "create_user__logs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logs.create_user__logs(@invalid_attrs)
    end

    test "update_user__logs/2 with valid data updates the user__logs" do
      user__logs = user__logs_fixture()
      assert {:ok, %User_Logs{} = user__logs} = Logs.update_user__logs(user__logs, @update_attrs)
      assert user__logs.activity == "some updated activity"
      assert user__logs.user_id == "some updated user_id"
    end

    test "update_user__logs/2 with invalid data returns error changeset" do
      user__logs = user__logs_fixture()
      assert {:error, %Ecto.Changeset{}} = Logs.update_user__logs(user__logs, @invalid_attrs)
      assert user__logs == Logs.get_user__logs!(user__logs.id)
    end

    test "delete_user__logs/1 deletes the user__logs" do
      user__logs = user__logs_fixture()
      assert {:ok, %User_Logs{}} = Logs.delete_user__logs(user__logs)
      assert_raise Ecto.NoResultsError, fn -> Logs.get_user__logs!(user__logs.id) end
    end

    test "change_user__logs/1 returns a user__logs changeset" do
      user__logs = user__logs_fixture()
      assert %Ecto.Changeset{} = Logs.change_user__logs(user__logs)
    end
  end

  describe "tbl_user_logs" do
    alias Fleet.Logs.UserLogs

    @valid_attrs %{activity: "some activity", user_id: "some user_id"}
    @update_attrs %{activity: "some updated activity", user_id: "some updated user_id"}
    @invalid_attrs %{activity: nil, user_id: nil}

    def user_logs_fixture(attrs \\ %{}) do
      {:ok, user_logs} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logs.create_user_logs()

      user_logs
    end

    test "list_tbl_user_logs/0 returns all tbl_user_logs" do
      user_logs = user_logs_fixture()
      assert Logs.list_tbl_user_logs() == [user_logs]
    end

    test "get_user_logs!/1 returns the user_logs with given id" do
      user_logs = user_logs_fixture()
      assert Logs.get_user_logs!(user_logs.id) == user_logs
    end

    test "create_user_logs/1 with valid data creates a user_logs" do
      assert {:ok, %UserLogs{} = user_logs} = Logs.create_user_logs(@valid_attrs)
      assert user_logs.activity == "some activity"
      assert user_logs.user_id == "some user_id"
    end

    test "create_user_logs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logs.create_user_logs(@invalid_attrs)
    end

    test "update_user_logs/2 with valid data updates the user_logs" do
      user_logs = user_logs_fixture()
      assert {:ok, %UserLogs{} = user_logs} = Logs.update_user_logs(user_logs, @update_attrs)
      assert user_logs.activity == "some updated activity"
      assert user_logs.user_id == "some updated user_id"
    end

    test "update_user_logs/2 with invalid data returns error changeset" do
      user_logs = user_logs_fixture()
      assert {:error, %Ecto.Changeset{}} = Logs.update_user_logs(user_logs, @invalid_attrs)
      assert user_logs == Logs.get_user_logs!(user_logs.id)
    end

    test "delete_user_logs/1 deletes the user_logs" do
      user_logs = user_logs_fixture()
      assert {:ok, %UserLogs{}} = Logs.delete_user_logs(user_logs)
      assert_raise Ecto.NoResultsError, fn -> Logs.get_user_logs!(user_logs.id) end
    end

    test "change_user_logs/1 returns a user_logs changeset" do
      user_logs = user_logs_fixture()
      assert %Ecto.Changeset{} = Logs.change_user_logs(user_logs)
    end
  end
end
