defmodule Fleet.ClientsTest do
  use Fleet.DataCase

  alias Fleet.Clients

  describe "tbl_contacts" do
    alias Fleet.Clients.Contacts

    @valid_attrs %{company: "some company", company_address: "some company_address", email: "some email", full_name: "some full_name", phone: "some phone", position: "some position"}
    @update_attrs %{company: "some updated company", company_address: "some updated company_address", email: "some updated email", full_name: "some updated full_name", phone: "some updated phone", position: "some updated position"}
    @invalid_attrs %{company: nil, company_address: nil, email: nil, full_name: nil, phone: nil, position: nil}

    def contacts_fixture(attrs \\ %{}) do
      {:ok, contacts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Clients.create_contacts()

      contacts
    end

    test "list_tbl_contacts/0 returns all tbl_contacts" do
      contacts = contacts_fixture()
      assert Clients.list_tbl_contacts() == [contacts]
    end

    test "get_contacts!/1 returns the contacts with given id" do
      contacts = contacts_fixture()
      assert Clients.get_contacts!(contacts.id) == contacts
    end

    test "create_contacts/1 with valid data creates a contacts" do
      assert {:ok, %Contacts{} = contacts} = Clients.create_contacts(@valid_attrs)
      assert contacts.company == "some company"
      assert contacts.company_address == "some company_address"
      assert contacts.email == "some email"
      assert contacts.full_name == "some full_name"
      assert contacts.phone == "some phone"
      assert contacts.position == "some position"
    end

    test "create_contacts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clients.create_contacts(@invalid_attrs)
    end

    test "update_contacts/2 with valid data updates the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{} = contacts} = Clients.update_contacts(contacts, @update_attrs)
      assert contacts.company == "some updated company"
      assert contacts.company_address == "some updated company_address"
      assert contacts.email == "some updated email"
      assert contacts.full_name == "some updated full_name"
      assert contacts.phone == "some updated phone"
      assert contacts.position == "some updated position"
    end

    test "update_contacts/2 with invalid data returns error changeset" do
      contacts = contacts_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.update_contacts(contacts, @invalid_attrs)
      assert contacts == Clients.get_contacts!(contacts.id)
    end

    test "delete_contacts/1 deletes the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{}} = Clients.delete_contacts(contacts)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_contacts!(contacts.id) end
    end

    test "change_contacts/1 returns a contacts changeset" do
      contacts = contacts_fixture()
      assert %Ecto.Changeset{} = Clients.change_contacts(contacts)
    end
  end

  describe "tbl_vendors" do
    alias Fleet.Clients.Contacts

    @valid_attrs %{comp_address: "some comp_address", comp_email: "some comp_email", comp_info: "some comp_info", comp_name: "some comp_name", comp_tel: "some comp_tel", email: "some email", position: "some position", rep_name: "some rep_name"}
    @update_attrs %{comp_address: "some updated comp_address", comp_email: "some updated comp_email", comp_info: "some updated comp_info", comp_name: "some updated comp_name", comp_tel: "some updated comp_tel", email: "some updated email", position: "some updated position", rep_name: "some updated rep_name"}
    @invalid_attrs %{comp_address: nil, comp_email: nil, comp_info: nil, comp_name: nil, comp_tel: nil, email: nil, position: nil, rep_name: nil}

    def contacts_fixture(attrs \\ %{}) do
      {:ok, contacts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Clients.create_contacts()

      contacts
    end

    test "list_tbl_vendors/0 returns all tbl_vendors" do
      contacts = contacts_fixture()
      assert Clients.list_tbl_vendors() == [contacts]
    end

    test "get_contacts!/1 returns the contacts with given id" do
      contacts = contacts_fixture()
      assert Clients.get_contacts!(contacts.id) == contacts
    end

    test "create_contacts/1 with valid data creates a contacts" do
      assert {:ok, %Contacts{} = contacts} = Clients.create_contacts(@valid_attrs)
      assert contacts.comp_address == "some comp_address"
      assert contacts.comp_email == "some comp_email"
      assert contacts.comp_info == "some comp_info"
      assert contacts.comp_name == "some comp_name"
      assert contacts.comp_tel == "some comp_tel"
      assert contacts.email == "some email"
      assert contacts.position == "some position"
      assert contacts.rep_name == "some rep_name"
    end

    test "create_contacts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clients.create_contacts(@invalid_attrs)
    end

    test "update_contacts/2 with valid data updates the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{} = contacts} = Clients.update_contacts(contacts, @update_attrs)
      assert contacts.comp_address == "some updated comp_address"
      assert contacts.comp_email == "some updated comp_email"
      assert contacts.comp_info == "some updated comp_info"
      assert contacts.comp_name == "some updated comp_name"
      assert contacts.comp_tel == "some updated comp_tel"
      assert contacts.email == "some updated email"
      assert contacts.position == "some updated position"
      assert contacts.rep_name == "some updated rep_name"
    end

    test "update_contacts/2 with invalid data returns error changeset" do
      contacts = contacts_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.update_contacts(contacts, @invalid_attrs)
      assert contacts == Clients.get_contacts!(contacts.id)
    end

    test "delete_contacts/1 deletes the contacts" do
      contacts = contacts_fixture()
      assert {:ok, %Contacts{}} = Clients.delete_contacts(contacts)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_contacts!(contacts.id) end
    end

    test "change_contacts/1 returns a contacts changeset" do
      contacts = contacts_fixture()
      assert %Ecto.Changeset{} = Clients.change_contacts(contacts)
    end
  end
end
