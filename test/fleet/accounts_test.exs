defmodule Fleet.AccountsTest do
  use Fleet.DataCase

  alias Fleet.Accounts

  describe "tbl_users" do
    alias Fleet.Accounts.UserAccounts

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", password: "some password", status: 42, user_id: "some user_id", user_role: "some user_role", user_type: 42}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password: "some updated password", status: 43, user_id: "some updated user_id", user_role: "some updated user_role", user_type: 43}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password: nil, status: nil, user_id: nil, user_role: nil, user_type: nil}

    def user_accounts_fixture(attrs \\ %{}) do
      {:ok, user_accounts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user_accounts()

      user_accounts
    end

    test "list_tbl_users/0 returns all tbl_users" do
      user_accounts = user_accounts_fixture()
      assert Accounts.list_tbl_users() == [user_accounts]
    end

    test "get_user_accounts!/1 returns the user_accounts with given id" do
      user_accounts = user_accounts_fixture()
      assert Accounts.get_user_accounts!(user_accounts.id) == user_accounts
    end

    test "create_user_accounts/1 with valid data creates a user_accounts" do
      assert {:ok, %UserAccounts{} = user_accounts} = Accounts.create_user_accounts(@valid_attrs)
      assert user_accounts.email == "some email"
      assert user_accounts.first_name == "some first_name"
      assert user_accounts.last_name == "some last_name"
      assert user_accounts.password == "some password"
      assert user_accounts.status == 42
      assert user_accounts.user_id == "some user_id"
      assert user_accounts.user_role == "some user_role"
      assert user_accounts.user_type == 42
    end

    test "create_user_accounts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user_accounts(@invalid_attrs)
    end

    test "update_user_accounts/2 with valid data updates the user_accounts" do
      user_accounts = user_accounts_fixture()
      assert {:ok, %UserAccounts{} = user_accounts} = Accounts.update_user_accounts(user_accounts, @update_attrs)
      assert user_accounts.email == "some updated email"
      assert user_accounts.first_name == "some updated first_name"
      assert user_accounts.last_name == "some updated last_name"
      assert user_accounts.password == "some updated password"
      assert user_accounts.status == 43
      assert user_accounts.user_id == "some updated user_id"
      assert user_accounts.user_role == "some updated user_role"
      assert user_accounts.user_type == 43
    end

    test "update_user_accounts/2 with invalid data returns error changeset" do
      user_accounts = user_accounts_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user_accounts(user_accounts, @invalid_attrs)
      assert user_accounts == Accounts.get_user_accounts!(user_accounts.id)
    end

    test "delete_user_accounts/1 deletes the user_accounts" do
      user_accounts = user_accounts_fixture()
      assert {:ok, %UserAccounts{}} = Accounts.delete_user_accounts(user_accounts)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user_accounts!(user_accounts.id) end
    end

    test "change_user_accounts/1 returns a user_accounts changeset" do
      user_accounts = user_accounts_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user_accounts(user_accounts)
    end
  end

  describe "tbl_users" do
    alias Fleet.Accounts.User

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", password: "some password", status: 42, user_id: "some user_id", user_role: "some user_role", user_type: 42}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", password: "some updated password", status: 43, user_id: "some updated user_id", user_role: "some updated user_role", user_type: 43}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, password: nil, status: nil, user_id: nil, user_role: nil, user_type: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_tbl_users/0 returns all tbl_users" do
      user = user_fixture()
      assert Accounts.list_tbl_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.password == "some password"
      assert user.status == 42
      assert user.user_id == "some user_id"
      assert user.user_role == "some user_role"
      assert user.user_type == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.password == "some updated password"
      assert user.status == 43
      assert user.user_id == "some updated user_id"
      assert user.user_role == "some updated user_role"
      assert user.user_type == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
