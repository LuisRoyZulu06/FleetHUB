defmodule Fleet.DriversTest do
  use Fleet.DataCase

  alias Fleet.Drivers

  describe "tbl_drivers" do
    alias Fleet.Drivers.DriverDetails

    @valid_attrs %{DLN: 42, DLT: "some DLT", Email: "some Email", Home_Add: "some Home_Add", NRC_No: 42, age: 42, first_name: "some first_name", last_name: "some last_name", phone: 42, sex: "some sex"}
    @update_attrs %{DLN: 43, DLT: "some updated DLT", Email: "some updated Email", Home_Add: "some updated Home_Add", NRC_No: 43, age: 43, first_name: "some updated first_name", last_name: "some updated last_name", phone: 43, sex: "some updated sex"}
    @invalid_attrs %{DLN: nil, DLT: nil, Email: nil, Home_Add: nil, NRC_No: nil, age: nil, first_name: nil, last_name: nil, phone: nil, sex: nil}

    def driver_details_fixture(attrs \\ %{}) do
      {:ok, driver_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_driver_details()

      driver_details
    end

    test "list_tbl_drivers/0 returns all tbl_drivers" do
      driver_details = driver_details_fixture()
      assert Drivers.list_tbl_drivers() == [driver_details]
    end

    test "get_driver_details!/1 returns the driver_details with given id" do
      driver_details = driver_details_fixture()
      assert Drivers.get_driver_details!(driver_details.id) == driver_details
    end

    test "create_driver_details/1 with valid data creates a driver_details" do
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.create_driver_details(@valid_attrs)
      assert driver_details.DLN == 42
      assert driver_details.DLT == "some DLT"
      assert driver_details.Email == "some Email"
      assert driver_details.Home_Add == "some Home_Add"
      assert driver_details.NRC_No == 42
      assert driver_details.age == 42
      assert driver_details.first_name == "some first_name"
      assert driver_details.last_name == "some last_name"
      assert driver_details.phone == 42
      assert driver_details.sex == "some sex"
    end

    test "create_driver_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver_details(@invalid_attrs)
    end

    test "update_driver_details/2 with valid data updates the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.update_driver_details(driver_details, @update_attrs)
      assert driver_details.DLN == 43
      assert driver_details.DLT == "some updated DLT"
      assert driver_details.Email == "some updated Email"
      assert driver_details.Home_Add == "some updated Home_Add"
      assert driver_details.NRC_No == 43
      assert driver_details.age == 43
      assert driver_details.first_name == "some updated first_name"
      assert driver_details.last_name == "some updated last_name"
      assert driver_details.phone == 43
      assert driver_details.sex == "some updated sex"
    end

    test "update_driver_details/2 with invalid data returns error changeset" do
      driver_details = driver_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver_details(driver_details, @invalid_attrs)
      assert driver_details == Drivers.get_driver_details!(driver_details.id)
    end

    test "delete_driver_details/1 deletes the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{}} = Drivers.delete_driver_details(driver_details)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver_details!(driver_details.id) end
    end

    test "change_driver_details/1 returns a driver_details changeset" do
      driver_details = driver_details_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver_details(driver_details)
    end
  end

  describe "tbl_drivers" do
    alias Fleet.Drivers.DriverDetails

    @valid_attrs %{DLN: 42, DLT: "some DLT", Email: "some Email", Home_Add: "some Home_Add", NRC_No: "some NRC_No", age: 42, first_name: "some first_name", last_name: "some last_name", phone: 42, sex: "some sex"}
    @update_attrs %{DLN: 43, DLT: "some updated DLT", Email: "some updated Email", Home_Add: "some updated Home_Add", NRC_No: "some updated NRC_No", age: 43, first_name: "some updated first_name", last_name: "some updated last_name", phone: 43, sex: "some updated sex"}
    @invalid_attrs %{DLN: nil, DLT: nil, Email: nil, Home_Add: nil, NRC_No: nil, age: nil, first_name: nil, last_name: nil, phone: nil, sex: nil}

    def driver_details_fixture(attrs \\ %{}) do
      {:ok, driver_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_driver_details()

      driver_details
    end

    test "list_tbl_drivers/0 returns all tbl_drivers" do
      driver_details = driver_details_fixture()
      assert Drivers.list_tbl_drivers() == [driver_details]
    end

    test "get_driver_details!/1 returns the driver_details with given id" do
      driver_details = driver_details_fixture()
      assert Drivers.get_driver_details!(driver_details.id) == driver_details
    end

    test "create_driver_details/1 with valid data creates a driver_details" do
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.create_driver_details(@valid_attrs)
      assert driver_details.DLN == 42
      assert driver_details.DLT == "some DLT"
      assert driver_details.Email == "some Email"
      assert driver_details.Home_Add == "some Home_Add"
      assert driver_details.NRC_No == "some NRC_No"
      assert driver_details.age == 42
      assert driver_details.first_name == "some first_name"
      assert driver_details.last_name == "some last_name"
      assert driver_details.phone == 42
      assert driver_details.sex == "some sex"
    end

    test "create_driver_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver_details(@invalid_attrs)
    end

    test "update_driver_details/2 with valid data updates the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.update_driver_details(driver_details, @update_attrs)
      assert driver_details.DLN == 43
      assert driver_details.DLT == "some updated DLT"
      assert driver_details.Email == "some updated Email"
      assert driver_details.Home_Add == "some updated Home_Add"
      assert driver_details.NRC_No == "some updated NRC_No"
      assert driver_details.age == 43
      assert driver_details.first_name == "some updated first_name"
      assert driver_details.last_name == "some updated last_name"
      assert driver_details.phone == 43
      assert driver_details.sex == "some updated sex"
    end

    test "update_driver_details/2 with invalid data returns error changeset" do
      driver_details = driver_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver_details(driver_details, @invalid_attrs)
      assert driver_details == Drivers.get_driver_details!(driver_details.id)
    end

    test "delete_driver_details/1 deletes the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{}} = Drivers.delete_driver_details(driver_details)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver_details!(driver_details.id) end
    end

    test "change_driver_details/1 returns a driver_details changeset" do
      driver_details = driver_details_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver_details(driver_details)
    end
  end

  describe "tbl_drivers" do
    alias Fleet.Drivers.DriverDetails

    @valid_attrs %{DLN: "some DLN", DLT: "some DLT", Email: "some Email", Home_Add: "some Home_Add", NRC_No: "some NRC_No", age: 42, first_name: "some first_name", last_name: "some last_name", phone: 42, sex: "some sex"}
    @update_attrs %{DLN: "some updated DLN", DLT: "some updated DLT", Email: "some updated Email", Home_Add: "some updated Home_Add", NRC_No: "some updated NRC_No", age: 43, first_name: "some updated first_name", last_name: "some updated last_name", phone: 43, sex: "some updated sex"}
    @invalid_attrs %{DLN: nil, DLT: nil, Email: nil, Home_Add: nil, NRC_No: nil, age: nil, first_name: nil, last_name: nil, phone: nil, sex: nil}

    def driver_details_fixture(attrs \\ %{}) do
      {:ok, driver_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_driver_details()

      driver_details
    end

    test "list_tbl_drivers/0 returns all tbl_drivers" do
      driver_details = driver_details_fixture()
      assert Drivers.list_tbl_drivers() == [driver_details]
    end

    test "get_driver_details!/1 returns the driver_details with given id" do
      driver_details = driver_details_fixture()
      assert Drivers.get_driver_details!(driver_details.id) == driver_details
    end

    test "create_driver_details/1 with valid data creates a driver_details" do
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.create_driver_details(@valid_attrs)
      assert driver_details.DLN == "some DLN"
      assert driver_details.DLT == "some DLT"
      assert driver_details.Email == "some Email"
      assert driver_details.Home_Add == "some Home_Add"
      assert driver_details.NRC_No == "some NRC_No"
      assert driver_details.age == 42
      assert driver_details.first_name == "some first_name"
      assert driver_details.last_name == "some last_name"
      assert driver_details.phone == 42
      assert driver_details.sex == "some sex"
    end

    test "create_driver_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver_details(@invalid_attrs)
    end

    test "update_driver_details/2 with valid data updates the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.update_driver_details(driver_details, @update_attrs)
      assert driver_details.DLN == "some updated DLN"
      assert driver_details.DLT == "some updated DLT"
      assert driver_details.Email == "some updated Email"
      assert driver_details.Home_Add == "some updated Home_Add"
      assert driver_details.NRC_No == "some updated NRC_No"
      assert driver_details.age == 43
      assert driver_details.first_name == "some updated first_name"
      assert driver_details.last_name == "some updated last_name"
      assert driver_details.phone == 43
      assert driver_details.sex == "some updated sex"
    end

    test "update_driver_details/2 with invalid data returns error changeset" do
      driver_details = driver_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver_details(driver_details, @invalid_attrs)
      assert driver_details == Drivers.get_driver_details!(driver_details.id)
    end

    test "delete_driver_details/1 deletes the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{}} = Drivers.delete_driver_details(driver_details)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver_details!(driver_details.id) end
    end

    test "change_driver_details/1 returns a driver_details changeset" do
      driver_details = driver_details_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver_details(driver_details)
    end
  end

  describe "tbl_drivers" do
    alias Fleet.Drivers.DriverDetails

    @valid_attrs %{age: 42, dln: 42, dlt: "some dlt", email: "some email", first_name: "some first_name", home_add: "some home_add", last_name: "some last_name", nrc_no: "some nrc_no", phone: 42, sex: "some sex"}
    @update_attrs %{age: 43, dln: 43, dlt: "some updated dlt", email: "some updated email", first_name: "some updated first_name", home_add: "some updated home_add", last_name: "some updated last_name", nrc_no: "some updated nrc_no", phone: 43, sex: "some updated sex"}
    @invalid_attrs %{age: nil, dln: nil, dlt: nil, email: nil, first_name: nil, home_add: nil, last_name: nil, nrc_no: nil, phone: nil, sex: nil}

    def driver_details_fixture(attrs \\ %{}) do
      {:ok, driver_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_driver_details()

      driver_details
    end

    test "list_tbl_drivers/0 returns all tbl_drivers" do
      driver_details = driver_details_fixture()
      assert Drivers.list_tbl_drivers() == [driver_details]
    end

    test "get_driver_details!/1 returns the driver_details with given id" do
      driver_details = driver_details_fixture()
      assert Drivers.get_driver_details!(driver_details.id) == driver_details
    end

    test "create_driver_details/1 with valid data creates a driver_details" do
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.create_driver_details(@valid_attrs)
      assert driver_details.age == 42
      assert driver_details.dln == 42
      assert driver_details.dlt == "some dlt"
      assert driver_details.email == "some email"
      assert driver_details.first_name == "some first_name"
      assert driver_details.home_add == "some home_add"
      assert driver_details.last_name == "some last_name"
      assert driver_details.nrc_no == "some nrc_no"
      assert driver_details.phone == 42
      assert driver_details.sex == "some sex"
    end

    test "create_driver_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver_details(@invalid_attrs)
    end

    test "update_driver_details/2 with valid data updates the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.update_driver_details(driver_details, @update_attrs)
      assert driver_details.age == 43
      assert driver_details.dln == 43
      assert driver_details.dlt == "some updated dlt"
      assert driver_details.email == "some updated email"
      assert driver_details.first_name == "some updated first_name"
      assert driver_details.home_add == "some updated home_add"
      assert driver_details.last_name == "some updated last_name"
      assert driver_details.nrc_no == "some updated nrc_no"
      assert driver_details.phone == 43
      assert driver_details.sex == "some updated sex"
    end

    test "update_driver_details/2 with invalid data returns error changeset" do
      driver_details = driver_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver_details(driver_details, @invalid_attrs)
      assert driver_details == Drivers.get_driver_details!(driver_details.id)
    end

    test "delete_driver_details/1 deletes the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{}} = Drivers.delete_driver_details(driver_details)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver_details!(driver_details.id) end
    end

    test "change_driver_details/1 returns a driver_details changeset" do
      driver_details = driver_details_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver_details(driver_details)
    end
  end

  describe "tbl_drivers" do
    alias Fleet.Drivers.DriverDetails

    @valid_attrs %{age: 42, dln: 42, dlt: "some dlt", email: "some email", first_name: "some first_name", home_add: "some home_add", last_name: "some last_name", nrc_no: "some nrc_no", phone: "some phone", sex: "some sex"}
    @update_attrs %{age: 43, dln: 43, dlt: "some updated dlt", email: "some updated email", first_name: "some updated first_name", home_add: "some updated home_add", last_name: "some updated last_name", nrc_no: "some updated nrc_no", phone: "some updated phone", sex: "some updated sex"}
    @invalid_attrs %{age: nil, dln: nil, dlt: nil, email: nil, first_name: nil, home_add: nil, last_name: nil, nrc_no: nil, phone: nil, sex: nil}

    def driver_details_fixture(attrs \\ %{}) do
      {:ok, driver_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_driver_details()

      driver_details
    end

    test "list_tbl_drivers/0 returns all tbl_drivers" do
      driver_details = driver_details_fixture()
      assert Drivers.list_tbl_drivers() == [driver_details]
    end

    test "get_driver_details!/1 returns the driver_details with given id" do
      driver_details = driver_details_fixture()
      assert Drivers.get_driver_details!(driver_details.id) == driver_details
    end

    test "create_driver_details/1 with valid data creates a driver_details" do
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.create_driver_details(@valid_attrs)
      assert driver_details.age == 42
      assert driver_details.dln == 42
      assert driver_details.dlt == "some dlt"
      assert driver_details.email == "some email"
      assert driver_details.first_name == "some first_name"
      assert driver_details.home_add == "some home_add"
      assert driver_details.last_name == "some last_name"
      assert driver_details.nrc_no == "some nrc_no"
      assert driver_details.phone == "some phone"
      assert driver_details.sex == "some sex"
    end

    test "create_driver_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver_details(@invalid_attrs)
    end

    test "update_driver_details/2 with valid data updates the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.update_driver_details(driver_details, @update_attrs)
      assert driver_details.age == 43
      assert driver_details.dln == 43
      assert driver_details.dlt == "some updated dlt"
      assert driver_details.email == "some updated email"
      assert driver_details.first_name == "some updated first_name"
      assert driver_details.home_add == "some updated home_add"
      assert driver_details.last_name == "some updated last_name"
      assert driver_details.nrc_no == "some updated nrc_no"
      assert driver_details.phone == "some updated phone"
      assert driver_details.sex == "some updated sex"
    end

    test "update_driver_details/2 with invalid data returns error changeset" do
      driver_details = driver_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver_details(driver_details, @invalid_attrs)
      assert driver_details == Drivers.get_driver_details!(driver_details.id)
    end

    test "delete_driver_details/1 deletes the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{}} = Drivers.delete_driver_details(driver_details)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver_details!(driver_details.id) end
    end

    test "change_driver_details/1 returns a driver_details changeset" do
      driver_details = driver_details_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver_details(driver_details)
    end
  end

  describe "tbl_drivers" do
    alias Fleet.Drivers.DriverDetails

    @valid_attrs %{age: 42, dln: "some dln", dlt: "some dlt", email: "some email", first_name: "some first_name", home_add: "some home_add", last_name: "some last_name", nrc_no: "some nrc_no", phone: "some phone", sex: "some sex"}
    @update_attrs %{age: 43, dln: "some updated dln", dlt: "some updated dlt", email: "some updated email", first_name: "some updated first_name", home_add: "some updated home_add", last_name: "some updated last_name", nrc_no: "some updated nrc_no", phone: "some updated phone", sex: "some updated sex"}
    @invalid_attrs %{age: nil, dln: nil, dlt: nil, email: nil, first_name: nil, home_add: nil, last_name: nil, nrc_no: nil, phone: nil, sex: nil}

    def driver_details_fixture(attrs \\ %{}) do
      {:ok, driver_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_driver_details()

      driver_details
    end

    test "list_tbl_drivers/0 returns all tbl_drivers" do
      driver_details = driver_details_fixture()
      assert Drivers.list_tbl_drivers() == [driver_details]
    end

    test "get_driver_details!/1 returns the driver_details with given id" do
      driver_details = driver_details_fixture()
      assert Drivers.get_driver_details!(driver_details.id) == driver_details
    end

    test "create_driver_details/1 with valid data creates a driver_details" do
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.create_driver_details(@valid_attrs)
      assert driver_details.age == 42
      assert driver_details.dln == "some dln"
      assert driver_details.dlt == "some dlt"
      assert driver_details.email == "some email"
      assert driver_details.first_name == "some first_name"
      assert driver_details.home_add == "some home_add"
      assert driver_details.last_name == "some last_name"
      assert driver_details.nrc_no == "some nrc_no"
      assert driver_details.phone == "some phone"
      assert driver_details.sex == "some sex"
    end

    test "create_driver_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver_details(@invalid_attrs)
    end

    test "update_driver_details/2 with valid data updates the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.update_driver_details(driver_details, @update_attrs)
      assert driver_details.age == 43
      assert driver_details.dln == "some updated dln"
      assert driver_details.dlt == "some updated dlt"
      assert driver_details.email == "some updated email"
      assert driver_details.first_name == "some updated first_name"
      assert driver_details.home_add == "some updated home_add"
      assert driver_details.last_name == "some updated last_name"
      assert driver_details.nrc_no == "some updated nrc_no"
      assert driver_details.phone == "some updated phone"
      assert driver_details.sex == "some updated sex"
    end

    test "update_driver_details/2 with invalid data returns error changeset" do
      driver_details = driver_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver_details(driver_details, @invalid_attrs)
      assert driver_details == Drivers.get_driver_details!(driver_details.id)
    end

    test "delete_driver_details/1 deletes the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{}} = Drivers.delete_driver_details(driver_details)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver_details!(driver_details.id) end
    end

    test "change_driver_details/1 returns a driver_details changeset" do
      driver_details = driver_details_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver_details(driver_details)
    end
  end

  describe "tbl_drivers" do
    alias Fleet.Drivers.DriverDetails

    @valid_attrs %{age: 42, dl_exp_dt: "some dl_exp_dt", dln: "some dln", dlt: "some dlt", email: "some email", first_name: "some first_name", home_add: "some home_add", last_name: "some last_name", nrc_no: "some nrc_no", phone: "some phone", sex: "some sex"}
    @update_attrs %{age: 43, dl_exp_dt: "some updated dl_exp_dt", dln: "some updated dln", dlt: "some updated dlt", email: "some updated email", first_name: "some updated first_name", home_add: "some updated home_add", last_name: "some updated last_name", nrc_no: "some updated nrc_no", phone: "some updated phone", sex: "some updated sex"}
    @invalid_attrs %{age: nil, dl_exp_dt: nil, dln: nil, dlt: nil, email: nil, first_name: nil, home_add: nil, last_name: nil, nrc_no: nil, phone: nil, sex: nil}

    def driver_details_fixture(attrs \\ %{}) do
      {:ok, driver_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_driver_details()

      driver_details
    end

    test "list_tbl_drivers/0 returns all tbl_drivers" do
      driver_details = driver_details_fixture()
      assert Drivers.list_tbl_drivers() == [driver_details]
    end

    test "get_driver_details!/1 returns the driver_details with given id" do
      driver_details = driver_details_fixture()
      assert Drivers.get_driver_details!(driver_details.id) == driver_details
    end

    test "create_driver_details/1 with valid data creates a driver_details" do
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.create_driver_details(@valid_attrs)
      assert driver_details.age == 42
      assert driver_details.dl_exp_dt == "some dl_exp_dt"
      assert driver_details.dln == "some dln"
      assert driver_details.dlt == "some dlt"
      assert driver_details.email == "some email"
      assert driver_details.first_name == "some first_name"
      assert driver_details.home_add == "some home_add"
      assert driver_details.last_name == "some last_name"
      assert driver_details.nrc_no == "some nrc_no"
      assert driver_details.phone == "some phone"
      assert driver_details.sex == "some sex"
    end

    test "create_driver_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_driver_details(@invalid_attrs)
    end

    test "update_driver_details/2 with valid data updates the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{} = driver_details} = Drivers.update_driver_details(driver_details, @update_attrs)
      assert driver_details.age == 43
      assert driver_details.dl_exp_dt == "some updated dl_exp_dt"
      assert driver_details.dln == "some updated dln"
      assert driver_details.dlt == "some updated dlt"
      assert driver_details.email == "some updated email"
      assert driver_details.first_name == "some updated first_name"
      assert driver_details.home_add == "some updated home_add"
      assert driver_details.last_name == "some updated last_name"
      assert driver_details.nrc_no == "some updated nrc_no"
      assert driver_details.phone == "some updated phone"
      assert driver_details.sex == "some updated sex"
    end

    test "update_driver_details/2 with invalid data returns error changeset" do
      driver_details = driver_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_driver_details(driver_details, @invalid_attrs)
      assert driver_details == Drivers.get_driver_details!(driver_details.id)
    end

    test "delete_driver_details/1 deletes the driver_details" do
      driver_details = driver_details_fixture()
      assert {:ok, %DriverDetails{}} = Drivers.delete_driver_details(driver_details)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_driver_details!(driver_details.id) end
    end

    test "change_driver_details/1 returns a driver_details changeset" do
      driver_details = driver_details_fixture()
      assert %Ecto.Changeset{} = Drivers.change_driver_details(driver_details)
    end
  end

  describe "tbl_vehicle_issue" do
    alias Fleet.Drivers.IssueLoger

    @valid_attrs %{cost: "some cost", dt_issued: "some dt_issued", dt_resolved: "some dt_resolved", frist_name: "some frist_name", last_name: "some last_name", payment_doc: "some payment_doc", phone: "some phone", v_fxd_problem: "some v_fxd_problem", v_make: "some v_make", v_name: "some v_name", v_plate_no: "some v_plate_no", v_problem: "some v_problem", v_status: "some v_status", vendor: "some vendor"}
    @update_attrs %{cost: "some updated cost", dt_issued: "some updated dt_issued", dt_resolved: "some updated dt_resolved", frist_name: "some updated frist_name", last_name: "some updated last_name", payment_doc: "some updated payment_doc", phone: "some updated phone", v_fxd_problem: "some updated v_fxd_problem", v_make: "some updated v_make", v_name: "some updated v_name", v_plate_no: "some updated v_plate_no", v_problem: "some updated v_problem", v_status: "some updated v_status", vendor: "some updated vendor"}
    @invalid_attrs %{cost: nil, dt_issued: nil, dt_resolved: nil, frist_name: nil, last_name: nil, payment_doc: nil, phone: nil, v_fxd_problem: nil, v_make: nil, v_name: nil, v_plate_no: nil, v_problem: nil, v_status: nil, vendor: nil}

    def issue_loger_fixture(attrs \\ %{}) do
      {:ok, issue_loger} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_issue_loger()

      issue_loger
    end

    test "list_tbl_vehicle_issue/0 returns all tbl_vehicle_issue" do
      issue_loger = issue_loger_fixture()
      assert Drivers.list_tbl_vehicle_issue() == [issue_loger]
    end

    test "get_issue_loger!/1 returns the issue_loger with given id" do
      issue_loger = issue_loger_fixture()
      assert Drivers.get_issue_loger!(issue_loger.id) == issue_loger
    end

    test "create_issue_loger/1 with valid data creates a issue_loger" do
      assert {:ok, %IssueLoger{} = issue_loger} = Drivers.create_issue_loger(@valid_attrs)
      assert issue_loger.cost == "some cost"
      assert issue_loger.dt_issued == "some dt_issued"
      assert issue_loger.dt_resolved == "some dt_resolved"
      assert issue_loger.frist_name == "some frist_name"
      assert issue_loger.last_name == "some last_name"
      assert issue_loger.payment_doc == "some payment_doc"
      assert issue_loger.phone == "some phone"
      assert issue_loger.v_fxd_problem == "some v_fxd_problem"
      assert issue_loger.v_make == "some v_make"
      assert issue_loger.v_name == "some v_name"
      assert issue_loger.v_plate_no == "some v_plate_no"
      assert issue_loger.v_problem == "some v_problem"
      assert issue_loger.v_status == "some v_status"
      assert issue_loger.vendor == "some vendor"
    end

    test "create_issue_loger/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_issue_loger(@invalid_attrs)
    end

    test "update_issue_loger/2 with valid data updates the issue_loger" do
      issue_loger = issue_loger_fixture()
      assert {:ok, %IssueLoger{} = issue_loger} = Drivers.update_issue_loger(issue_loger, @update_attrs)
      assert issue_loger.cost == "some updated cost"
      assert issue_loger.dt_issued == "some updated dt_issued"
      assert issue_loger.dt_resolved == "some updated dt_resolved"
      assert issue_loger.frist_name == "some updated frist_name"
      assert issue_loger.last_name == "some updated last_name"
      assert issue_loger.payment_doc == "some updated payment_doc"
      assert issue_loger.phone == "some updated phone"
      assert issue_loger.v_fxd_problem == "some updated v_fxd_problem"
      assert issue_loger.v_make == "some updated v_make"
      assert issue_loger.v_name == "some updated v_name"
      assert issue_loger.v_plate_no == "some updated v_plate_no"
      assert issue_loger.v_problem == "some updated v_problem"
      assert issue_loger.v_status == "some updated v_status"
      assert issue_loger.vendor == "some updated vendor"
    end

    test "update_issue_loger/2 with invalid data returns error changeset" do
      issue_loger = issue_loger_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_issue_loger(issue_loger, @invalid_attrs)
      assert issue_loger == Drivers.get_issue_loger!(issue_loger.id)
    end

    test "delete_issue_loger/1 deletes the issue_loger" do
      issue_loger = issue_loger_fixture()
      assert {:ok, %IssueLoger{}} = Drivers.delete_issue_loger(issue_loger)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_issue_loger!(issue_loger.id) end
    end

    test "change_issue_loger/1 returns a issue_loger changeset" do
      issue_loger = issue_loger_fixture()
      assert %Ecto.Changeset{} = Drivers.change_issue_loger(issue_loger)
    end
  end

  describe "tbl_vehicle_issue" do
    alias Fleet.Drivers.IssueLoger

    @valid_attrs %{cost: "some cost", dt_issued: "some dt_issued", dt_resolved: "some dt_resolved", first_name: "some first_name", last_name: "some last_name", payment_doc: "some payment_doc", phone: "some phone", v_fxd_problem: "some v_fxd_problem", v_make: "some v_make", v_name: "some v_name", v_plate_no: "some v_plate_no", v_problem: "some v_problem", v_status: "some v_status", vendor: "some vendor"}
    @update_attrs %{cost: "some updated cost", dt_issued: "some updated dt_issued", dt_resolved: "some updated dt_resolved", first_name: "some updated first_name", last_name: "some updated last_name", payment_doc: "some updated payment_doc", phone: "some updated phone", v_fxd_problem: "some updated v_fxd_problem", v_make: "some updated v_make", v_name: "some updated v_name", v_plate_no: "some updated v_plate_no", v_problem: "some updated v_problem", v_status: "some updated v_status", vendor: "some updated vendor"}
    @invalid_attrs %{cost: nil, dt_issued: nil, dt_resolved: nil, first_name: nil, last_name: nil, payment_doc: nil, phone: nil, v_fxd_problem: nil, v_make: nil, v_name: nil, v_plate_no: nil, v_problem: nil, v_status: nil, vendor: nil}

    def issue_loger_fixture(attrs \\ %{}) do
      {:ok, issue_loger} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_issue_loger()

      issue_loger
    end

    test "list_tbl_vehicle_issue/0 returns all tbl_vehicle_issue" do
      issue_loger = issue_loger_fixture()
      assert Drivers.list_tbl_vehicle_issue() == [issue_loger]
    end

    test "get_issue_loger!/1 returns the issue_loger with given id" do
      issue_loger = issue_loger_fixture()
      assert Drivers.get_issue_loger!(issue_loger.id) == issue_loger
    end

    test "create_issue_loger/1 with valid data creates a issue_loger" do
      assert {:ok, %IssueLoger{} = issue_loger} = Drivers.create_issue_loger(@valid_attrs)
      assert issue_loger.cost == "some cost"
      assert issue_loger.dt_issued == "some dt_issued"
      assert issue_loger.dt_resolved == "some dt_resolved"
      assert issue_loger.first_name == "some first_name"
      assert issue_loger.last_name == "some last_name"
      assert issue_loger.payment_doc == "some payment_doc"
      assert issue_loger.phone == "some phone"
      assert issue_loger.v_fxd_problem == "some v_fxd_problem"
      assert issue_loger.v_make == "some v_make"
      assert issue_loger.v_name == "some v_name"
      assert issue_loger.v_plate_no == "some v_plate_no"
      assert issue_loger.v_problem == "some v_problem"
      assert issue_loger.v_status == "some v_status"
      assert issue_loger.vendor == "some vendor"
    end

    test "create_issue_loger/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_issue_loger(@invalid_attrs)
    end

    test "update_issue_loger/2 with valid data updates the issue_loger" do
      issue_loger = issue_loger_fixture()
      assert {:ok, %IssueLoger{} = issue_loger} = Drivers.update_issue_loger(issue_loger, @update_attrs)
      assert issue_loger.cost == "some updated cost"
      assert issue_loger.dt_issued == "some updated dt_issued"
      assert issue_loger.dt_resolved == "some updated dt_resolved"
      assert issue_loger.first_name == "some updated first_name"
      assert issue_loger.last_name == "some updated last_name"
      assert issue_loger.payment_doc == "some updated payment_doc"
      assert issue_loger.phone == "some updated phone"
      assert issue_loger.v_fxd_problem == "some updated v_fxd_problem"
      assert issue_loger.v_make == "some updated v_make"
      assert issue_loger.v_name == "some updated v_name"
      assert issue_loger.v_plate_no == "some updated v_plate_no"
      assert issue_loger.v_problem == "some updated v_problem"
      assert issue_loger.v_status == "some updated v_status"
      assert issue_loger.vendor == "some updated vendor"
    end

    test "update_issue_loger/2 with invalid data returns error changeset" do
      issue_loger = issue_loger_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_issue_loger(issue_loger, @invalid_attrs)
      assert issue_loger == Drivers.get_issue_loger!(issue_loger.id)
    end

    test "delete_issue_loger/1 deletes the issue_loger" do
      issue_loger = issue_loger_fixture()
      assert {:ok, %IssueLoger{}} = Drivers.delete_issue_loger(issue_loger)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_issue_loger!(issue_loger.id) end
    end

    test "change_issue_loger/1 returns a issue_loger changeset" do
      issue_loger = issue_loger_fixture()
      assert %Ecto.Changeset{} = Drivers.change_issue_loger(issue_loger)
    end
  end

  describe "tbl_vehicle_issue" do
    alias Fleet.Drivers.IssueLoger

    @valid_attrs %{cost: "some cost", dt_issued: "some dt_issued", dt_resolved: "some dt_resolved", first_name: "some first_name", last_name: "some last_name", payment_doc: "some payment_doc", phone: "some phone", v_descr_problem: "some v_descr_problem", v_fxd_problem: "some v_fxd_problem", v_make: "some v_make", v_name: "some v_name", v_plate_no: "some v_plate_no", v_slct_problem: "some v_slct_problem", v_status: "some v_status", vendor: "some vendor"}
    @update_attrs %{cost: "some updated cost", dt_issued: "some updated dt_issued", dt_resolved: "some updated dt_resolved", first_name: "some updated first_name", last_name: "some updated last_name", payment_doc: "some updated payment_doc", phone: "some updated phone", v_descr_problem: "some updated v_descr_problem", v_fxd_problem: "some updated v_fxd_problem", v_make: "some updated v_make", v_name: "some updated v_name", v_plate_no: "some updated v_plate_no", v_slct_problem: "some updated v_slct_problem", v_status: "some updated v_status", vendor: "some updated vendor"}
    @invalid_attrs %{cost: nil, dt_issued: nil, dt_resolved: nil, first_name: nil, last_name: nil, payment_doc: nil, phone: nil, v_descr_problem: nil, v_fxd_problem: nil, v_make: nil, v_name: nil, v_plate_no: nil, v_slct_problem: nil, v_status: nil, vendor: nil}

    def issue_loger_fixture(attrs \\ %{}) do
      {:ok, issue_loger} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_issue_loger()

      issue_loger
    end

    test "list_tbl_vehicle_issue/0 returns all tbl_vehicle_issue" do
      issue_loger = issue_loger_fixture()
      assert Drivers.list_tbl_vehicle_issue() == [issue_loger]
    end

    test "get_issue_loger!/1 returns the issue_loger with given id" do
      issue_loger = issue_loger_fixture()
      assert Drivers.get_issue_loger!(issue_loger.id) == issue_loger
    end

    test "create_issue_loger/1 with valid data creates a issue_loger" do
      assert {:ok, %IssueLoger{} = issue_loger} = Drivers.create_issue_loger(@valid_attrs)
      assert issue_loger.cost == "some cost"
      assert issue_loger.dt_issued == "some dt_issued"
      assert issue_loger.dt_resolved == "some dt_resolved"
      assert issue_loger.first_name == "some first_name"
      assert issue_loger.last_name == "some last_name"
      assert issue_loger.payment_doc == "some payment_doc"
      assert issue_loger.phone == "some phone"
      assert issue_loger.v_descr_problem == "some v_descr_problem"
      assert issue_loger.v_fxd_problem == "some v_fxd_problem"
      assert issue_loger.v_make == "some v_make"
      assert issue_loger.v_name == "some v_name"
      assert issue_loger.v_plate_no == "some v_plate_no"
      assert issue_loger.v_slct_problem == "some v_slct_problem"
      assert issue_loger.v_status == "some v_status"
      assert issue_loger.vendor == "some vendor"
    end

    test "create_issue_loger/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_issue_loger(@invalid_attrs)
    end

    test "update_issue_loger/2 with valid data updates the issue_loger" do
      issue_loger = issue_loger_fixture()
      assert {:ok, %IssueLoger{} = issue_loger} = Drivers.update_issue_loger(issue_loger, @update_attrs)
      assert issue_loger.cost == "some updated cost"
      assert issue_loger.dt_issued == "some updated dt_issued"
      assert issue_loger.dt_resolved == "some updated dt_resolved"
      assert issue_loger.first_name == "some updated first_name"
      assert issue_loger.last_name == "some updated last_name"
      assert issue_loger.payment_doc == "some updated payment_doc"
      assert issue_loger.phone == "some updated phone"
      assert issue_loger.v_descr_problem == "some updated v_descr_problem"
      assert issue_loger.v_fxd_problem == "some updated v_fxd_problem"
      assert issue_loger.v_make == "some updated v_make"
      assert issue_loger.v_name == "some updated v_name"
      assert issue_loger.v_plate_no == "some updated v_plate_no"
      assert issue_loger.v_slct_problem == "some updated v_slct_problem"
      assert issue_loger.v_status == "some updated v_status"
      assert issue_loger.vendor == "some updated vendor"
    end

    test "update_issue_loger/2 with invalid data returns error changeset" do
      issue_loger = issue_loger_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_issue_loger(issue_loger, @invalid_attrs)
      assert issue_loger == Drivers.get_issue_loger!(issue_loger.id)
    end

    test "delete_issue_loger/1 deletes the issue_loger" do
      issue_loger = issue_loger_fixture()
      assert {:ok, %IssueLoger{}} = Drivers.delete_issue_loger(issue_loger)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_issue_loger!(issue_loger.id) end
    end

    test "change_issue_loger/1 returns a issue_loger changeset" do
      issue_loger = issue_loger_fixture()
      assert %Ecto.Changeset{} = Drivers.change_issue_loger(issue_loger)
    end
  end

  describe "tbl_vehicle_issue" do
    alias Fleet.Drivers.IssueLoger

    @valid_attrs %{cost: "some cost", descr_fxd_problem: "some descr_fxd_problem", dt_issued: "some dt_issued", dt_resolved: "some dt_resolved", first_name: "some first_name", last_name: "some last_name", payment_doc: "some payment_doc", phone: "some phone", slct_fxd_problem: "some slct_fxd_problem", v_descr_problem: "some v_descr_problem", v_make: "some v_make", v_name: "some v_name", v_plate_no: "some v_plate_no", v_slct_problem: "some v_slct_problem", v_status: "some v_status", vendor: "some vendor"}
    @update_attrs %{cost: "some updated cost", descr_fxd_problem: "some updated descr_fxd_problem", dt_issued: "some updated dt_issued", dt_resolved: "some updated dt_resolved", first_name: "some updated first_name", last_name: "some updated last_name", payment_doc: "some updated payment_doc", phone: "some updated phone", slct_fxd_problem: "some updated slct_fxd_problem", v_descr_problem: "some updated v_descr_problem", v_make: "some updated v_make", v_name: "some updated v_name", v_plate_no: "some updated v_plate_no", v_slct_problem: "some updated v_slct_problem", v_status: "some updated v_status", vendor: "some updated vendor"}
    @invalid_attrs %{cost: nil, descr_fxd_problem: nil, dt_issued: nil, dt_resolved: nil, first_name: nil, last_name: nil, payment_doc: nil, phone: nil, slct_fxd_problem: nil, v_descr_problem: nil, v_make: nil, v_name: nil, v_plate_no: nil, v_slct_problem: nil, v_status: nil, vendor: nil}

    def issue_loger_fixture(attrs \\ %{}) do
      {:ok, issue_loger} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Drivers.create_issue_loger()

      issue_loger
    end

    test "list_tbl_vehicle_issue/0 returns all tbl_vehicle_issue" do
      issue_loger = issue_loger_fixture()
      assert Drivers.list_tbl_vehicle_issue() == [issue_loger]
    end

    test "get_issue_loger!/1 returns the issue_loger with given id" do
      issue_loger = issue_loger_fixture()
      assert Drivers.get_issue_loger!(issue_loger.id) == issue_loger
    end

    test "create_issue_loger/1 with valid data creates a issue_loger" do
      assert {:ok, %IssueLoger{} = issue_loger} = Drivers.create_issue_loger(@valid_attrs)
      assert issue_loger.cost == "some cost"
      assert issue_loger.descr_fxd_problem == "some descr_fxd_problem"
      assert issue_loger.dt_issued == "some dt_issued"
      assert issue_loger.dt_resolved == "some dt_resolved"
      assert issue_loger.first_name == "some first_name"
      assert issue_loger.last_name == "some last_name"
      assert issue_loger.payment_doc == "some payment_doc"
      assert issue_loger.phone == "some phone"
      assert issue_loger.slct_fxd_problem == "some slct_fxd_problem"
      assert issue_loger.v_descr_problem == "some v_descr_problem"
      assert issue_loger.v_make == "some v_make"
      assert issue_loger.v_name == "some v_name"
      assert issue_loger.v_plate_no == "some v_plate_no"
      assert issue_loger.v_slct_problem == "some v_slct_problem"
      assert issue_loger.v_status == "some v_status"
      assert issue_loger.vendor == "some vendor"
    end

    test "create_issue_loger/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drivers.create_issue_loger(@invalid_attrs)
    end

    test "update_issue_loger/2 with valid data updates the issue_loger" do
      issue_loger = issue_loger_fixture()
      assert {:ok, %IssueLoger{} = issue_loger} = Drivers.update_issue_loger(issue_loger, @update_attrs)
      assert issue_loger.cost == "some updated cost"
      assert issue_loger.descr_fxd_problem == "some updated descr_fxd_problem"
      assert issue_loger.dt_issued == "some updated dt_issued"
      assert issue_loger.dt_resolved == "some updated dt_resolved"
      assert issue_loger.first_name == "some updated first_name"
      assert issue_loger.last_name == "some updated last_name"
      assert issue_loger.payment_doc == "some updated payment_doc"
      assert issue_loger.phone == "some updated phone"
      assert issue_loger.slct_fxd_problem == "some updated slct_fxd_problem"
      assert issue_loger.v_descr_problem == "some updated v_descr_problem"
      assert issue_loger.v_make == "some updated v_make"
      assert issue_loger.v_name == "some updated v_name"
      assert issue_loger.v_plate_no == "some updated v_plate_no"
      assert issue_loger.v_slct_problem == "some updated v_slct_problem"
      assert issue_loger.v_status == "some updated v_status"
      assert issue_loger.vendor == "some updated vendor"
    end

    test "update_issue_loger/2 with invalid data returns error changeset" do
      issue_loger = issue_loger_fixture()
      assert {:error, %Ecto.Changeset{}} = Drivers.update_issue_loger(issue_loger, @invalid_attrs)
      assert issue_loger == Drivers.get_issue_loger!(issue_loger.id)
    end

    test "delete_issue_loger/1 deletes the issue_loger" do
      issue_loger = issue_loger_fixture()
      assert {:ok, %IssueLoger{}} = Drivers.delete_issue_loger(issue_loger)
      assert_raise Ecto.NoResultsError, fn -> Drivers.get_issue_loger!(issue_loger.id) end
    end

    test "change_issue_loger/1 returns a issue_loger changeset" do
      issue_loger = issue_loger_fixture()
      assert %Ecto.Changeset{} = Drivers.change_issue_loger(issue_loger)
    end
  end
end
