defmodule Fleet.VehiclesTest do
  use Fleet.DataCase

  alias Fleet.Vehicles

  describe "tbl_vehicles" do
    alias Fleet.Vehicles.VehicleDetails

    @valid_attrs %{assigned_to: "some assigned_to", assignment_status: "some assignment_status", color: "some color", plate_no: "some plate_no", v_make: "some v_make", v_name: "some v_name", v_status: "some v_status"}
    @update_attrs %{assigned_to: "some updated assigned_to", assignment_status: "some updated assignment_status", color: "some updated color", plate_no: "some updated plate_no", v_make: "some updated v_make", v_name: "some updated v_name", v_status: "some updated v_status"}
    @invalid_attrs %{assigned_to: nil, assignment_status: nil, color: nil, plate_no: nil, v_make: nil, v_name: nil, v_status: nil}

    def vehicle_details_fixture(attrs \\ %{}) do
      {:ok, vehicle_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Vehicles.create_vehicle_details()

      vehicle_details
    end

    test "list_tbl_vehicles/0 returns all tbl_vehicles" do
      vehicle_details = vehicle_details_fixture()
      assert Vehicles.list_tbl_vehicles() == [vehicle_details]
    end

    test "get_vehicle_details!/1 returns the vehicle_details with given id" do
      vehicle_details = vehicle_details_fixture()
      assert Vehicles.get_vehicle_details!(vehicle_details.id) == vehicle_details
    end

    test "create_vehicle_details/1 with valid data creates a vehicle_details" do
      assert {:ok, %VehicleDetails{} = vehicle_details} = Vehicles.create_vehicle_details(@valid_attrs)
      assert vehicle_details.assigned_to == "some assigned_to"
      assert vehicle_details.assignment_status == "some assignment_status"
      assert vehicle_details.color == "some color"
      assert vehicle_details.plate_no == "some plate_no"
      assert vehicle_details.v_make == "some v_make"
      assert vehicle_details.v_name == "some v_name"
      assert vehicle_details.v_status == "some v_status"
    end

    test "create_vehicle_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicles.create_vehicle_details(@invalid_attrs)
    end

    test "update_vehicle_details/2 with valid data updates the vehicle_details" do
      vehicle_details = vehicle_details_fixture()
      assert {:ok, %VehicleDetails{} = vehicle_details} = Vehicles.update_vehicle_details(vehicle_details, @update_attrs)
      assert vehicle_details.assigned_to == "some updated assigned_to"
      assert vehicle_details.assignment_status == "some updated assignment_status"
      assert vehicle_details.color == "some updated color"
      assert vehicle_details.plate_no == "some updated plate_no"
      assert vehicle_details.v_make == "some updated v_make"
      assert vehicle_details.v_name == "some updated v_name"
      assert vehicle_details.v_status == "some updated v_status"
    end

    test "update_vehicle_details/2 with invalid data returns error changeset" do
      vehicle_details = vehicle_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicles.update_vehicle_details(vehicle_details, @invalid_attrs)
      assert vehicle_details == Vehicles.get_vehicle_details!(vehicle_details.id)
    end

    test "delete_vehicle_details/1 deletes the vehicle_details" do
      vehicle_details = vehicle_details_fixture()
      assert {:ok, %VehicleDetails{}} = Vehicles.delete_vehicle_details(vehicle_details)
      assert_raise Ecto.NoResultsError, fn -> Vehicles.get_vehicle_details!(vehicle_details.id) end
    end

    test "change_vehicle_details/1 returns a vehicle_details changeset" do
      vehicle_details = vehicle_details_fixture()
      assert %Ecto.Changeset{} = Vehicles.change_vehicle_details(vehicle_details)
    end
  end

  describe "tbl_vehicles" do
    alias Fleet.Vehicles.VehicleDetails

    @valid_attrs %{assigned_to: "some assigned_to", assignment_status: "some assignment_status", color: "some color", mileage: "some mileage", plate_no: "some plate_no", v_make: "some v_make", v_name: "some v_name", v_status: "some v_status"}
    @update_attrs %{assigned_to: "some updated assigned_to", assignment_status: "some updated assignment_status", color: "some updated color", mileage: "some updated mileage", plate_no: "some updated plate_no", v_make: "some updated v_make", v_name: "some updated v_name", v_status: "some updated v_status"}
    @invalid_attrs %{assigned_to: nil, assignment_status: nil, color: nil, mileage: nil, plate_no: nil, v_make: nil, v_name: nil, v_status: nil}

    def vehicle_details_fixture(attrs \\ %{}) do
      {:ok, vehicle_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Vehicles.create_vehicle_details()

      vehicle_details
    end

    test "list_tbl_vehicles/0 returns all tbl_vehicles" do
      vehicle_details = vehicle_details_fixture()
      assert Vehicles.list_tbl_vehicles() == [vehicle_details]
    end

    test "get_vehicle_details!/1 returns the vehicle_details with given id" do
      vehicle_details = vehicle_details_fixture()
      assert Vehicles.get_vehicle_details!(vehicle_details.id) == vehicle_details
    end

    test "create_vehicle_details/1 with valid data creates a vehicle_details" do
      assert {:ok, %VehicleDetails{} = vehicle_details} = Vehicles.create_vehicle_details(@valid_attrs)
      assert vehicle_details.assigned_to == "some assigned_to"
      assert vehicle_details.assignment_status == "some assignment_status"
      assert vehicle_details.color == "some color"
      assert vehicle_details.mileage == "some mileage"
      assert vehicle_details.plate_no == "some plate_no"
      assert vehicle_details.v_make == "some v_make"
      assert vehicle_details.v_name == "some v_name"
      assert vehicle_details.v_status == "some v_status"
    end

    test "create_vehicle_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicles.create_vehicle_details(@invalid_attrs)
    end

    test "update_vehicle_details/2 with valid data updates the vehicle_details" do
      vehicle_details = vehicle_details_fixture()
      assert {:ok, %VehicleDetails{} = vehicle_details} = Vehicles.update_vehicle_details(vehicle_details, @update_attrs)
      assert vehicle_details.assigned_to == "some updated assigned_to"
      assert vehicle_details.assignment_status == "some updated assignment_status"
      assert vehicle_details.color == "some updated color"
      assert vehicle_details.mileage == "some updated mileage"
      assert vehicle_details.plate_no == "some updated plate_no"
      assert vehicle_details.v_make == "some updated v_make"
      assert vehicle_details.v_name == "some updated v_name"
      assert vehicle_details.v_status == "some updated v_status"
    end

    test "update_vehicle_details/2 with invalid data returns error changeset" do
      vehicle_details = vehicle_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicles.update_vehicle_details(vehicle_details, @invalid_attrs)
      assert vehicle_details == Vehicles.get_vehicle_details!(vehicle_details.id)
    end

    test "delete_vehicle_details/1 deletes the vehicle_details" do
      vehicle_details = vehicle_details_fixture()
      assert {:ok, %VehicleDetails{}} = Vehicles.delete_vehicle_details(vehicle_details)
      assert_raise Ecto.NoResultsError, fn -> Vehicles.get_vehicle_details!(vehicle_details.id) end
    end

    test "change_vehicle_details/1 returns a vehicle_details changeset" do
      vehicle_details = vehicle_details_fixture()
      assert %Ecto.Changeset{} = Vehicles.change_vehicle_details(vehicle_details)
    end
  end

  describe "tbl_vehicles" do
    alias Fleet.Vehicles.VehicleDetails

    @valid_attrs %{assigned_to: "some assigned_to", assignment_status: "some assignment_status", color: "some color", fitness_exp_dt: "some fitness_exp_dt", insrnc_exp_dt: "some insrnc_exp_dt", mileage: "some mileage", plate_no: "some plate_no", rd_tax_exp_dt: "some rd_tax_exp_dt", v_make: "some v_make", v_name: "some v_name", v_status: "some v_status"}
    @update_attrs %{assigned_to: "some updated assigned_to", assignment_status: "some updated assignment_status", color: "some updated color", fitness_exp_dt: "some updated fitness_exp_dt", insrnc_exp_dt: "some updated insrnc_exp_dt", mileage: "some updated mileage", plate_no: "some updated plate_no", rd_tax_exp_dt: "some updated rd_tax_exp_dt", v_make: "some updated v_make", v_name: "some updated v_name", v_status: "some updated v_status"}
    @invalid_attrs %{assigned_to: nil, assignment_status: nil, color: nil, fitness_exp_dt: nil, insrnc_exp_dt: nil, mileage: nil, plate_no: nil, rd_tax_exp_dt: nil, v_make: nil, v_name: nil, v_status: nil}

    def vehicle_details_fixture(attrs \\ %{}) do
      {:ok, vehicle_details} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Vehicles.create_vehicle_details()

      vehicle_details
    end

    test "list_tbl_vehicles/0 returns all tbl_vehicles" do
      vehicle_details = vehicle_details_fixture()
      assert Vehicles.list_tbl_vehicles() == [vehicle_details]
    end

    test "get_vehicle_details!/1 returns the vehicle_details with given id" do
      vehicle_details = vehicle_details_fixture()
      assert Vehicles.get_vehicle_details!(vehicle_details.id) == vehicle_details
    end

    test "create_vehicle_details/1 with valid data creates a vehicle_details" do
      assert {:ok, %VehicleDetails{} = vehicle_details} = Vehicles.create_vehicle_details(@valid_attrs)
      assert vehicle_details.assigned_to == "some assigned_to"
      assert vehicle_details.assignment_status == "some assignment_status"
      assert vehicle_details.color == "some color"
      assert vehicle_details.fitness_exp_dt == "some fitness_exp_dt"
      assert vehicle_details.insrnc_exp_dt == "some insrnc_exp_dt"
      assert vehicle_details.mileage == "some mileage"
      assert vehicle_details.plate_no == "some plate_no"
      assert vehicle_details.rd_tax_exp_dt == "some rd_tax_exp_dt"
      assert vehicle_details.v_make == "some v_make"
      assert vehicle_details.v_name == "some v_name"
      assert vehicle_details.v_status == "some v_status"
    end

    test "create_vehicle_details/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vehicles.create_vehicle_details(@invalid_attrs)
    end

    test "update_vehicle_details/2 with valid data updates the vehicle_details" do
      vehicle_details = vehicle_details_fixture()
      assert {:ok, %VehicleDetails{} = vehicle_details} = Vehicles.update_vehicle_details(vehicle_details, @update_attrs)
      assert vehicle_details.assigned_to == "some updated assigned_to"
      assert vehicle_details.assignment_status == "some updated assignment_status"
      assert vehicle_details.color == "some updated color"
      assert vehicle_details.fitness_exp_dt == "some updated fitness_exp_dt"
      assert vehicle_details.insrnc_exp_dt == "some updated insrnc_exp_dt"
      assert vehicle_details.mileage == "some updated mileage"
      assert vehicle_details.plate_no == "some updated plate_no"
      assert vehicle_details.rd_tax_exp_dt == "some updated rd_tax_exp_dt"
      assert vehicle_details.v_make == "some updated v_make"
      assert vehicle_details.v_name == "some updated v_name"
      assert vehicle_details.v_status == "some updated v_status"
    end

    test "update_vehicle_details/2 with invalid data returns error changeset" do
      vehicle_details = vehicle_details_fixture()
      assert {:error, %Ecto.Changeset{}} = Vehicles.update_vehicle_details(vehicle_details, @invalid_attrs)
      assert vehicle_details == Vehicles.get_vehicle_details!(vehicle_details.id)
    end

    test "delete_vehicle_details/1 deletes the vehicle_details" do
      vehicle_details = vehicle_details_fixture()
      assert {:ok, %VehicleDetails{}} = Vehicles.delete_vehicle_details(vehicle_details)
      assert_raise Ecto.NoResultsError, fn -> Vehicles.get_vehicle_details!(vehicle_details.id) end
    end

    test "change_vehicle_details/1 returns a vehicle_details changeset" do
      vehicle_details = vehicle_details_fixture()
      assert %Ecto.Changeset{} = Vehicles.change_vehicle_details(vehicle_details)
    end
  end
end
