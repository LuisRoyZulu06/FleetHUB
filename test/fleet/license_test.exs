defmodule Fleet.LicenseTest do
  use Fleet.DataCase

  alias Fleet.License

  describe "tbl_license_type" do
    alias Fleet.License.Drivers_license

    @valid_attrs %{name: "some name", vehicle_cat: "some vehicle_cat", weight: "some weight"}
    @update_attrs %{name: "some updated name", vehicle_cat: "some updated vehicle_cat", weight: "some updated weight"}
    @invalid_attrs %{name: nil, vehicle_cat: nil, weight: nil}

    def drivers_license_fixture(attrs \\ %{}) do
      {:ok, drivers_license} =
        attrs
        |> Enum.into(@valid_attrs)
        |> License.create_drivers_license()

      drivers_license
    end

    test "list_tbl_license_type/0 returns all tbl_license_type" do
      drivers_license = drivers_license_fixture()
      assert License.list_tbl_license_type() == [drivers_license]
    end

    test "get_drivers_license!/1 returns the drivers_license with given id" do
      drivers_license = drivers_license_fixture()
      assert License.get_drivers_license!(drivers_license.id) == drivers_license
    end

    test "create_drivers_license/1 with valid data creates a drivers_license" do
      assert {:ok, %Drivers_license{} = drivers_license} = License.create_drivers_license(@valid_attrs)
      assert drivers_license.name == "some name"
      assert drivers_license.vehicle_cat == "some vehicle_cat"
      assert drivers_license.weight == "some weight"
    end

    test "create_drivers_license/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = License.create_drivers_license(@invalid_attrs)
    end

    test "update_drivers_license/2 with valid data updates the drivers_license" do
      drivers_license = drivers_license_fixture()
      assert {:ok, %Drivers_license{} = drivers_license} = License.update_drivers_license(drivers_license, @update_attrs)
      assert drivers_license.name == "some updated name"
      assert drivers_license.vehicle_cat == "some updated vehicle_cat"
      assert drivers_license.weight == "some updated weight"
    end

    test "update_drivers_license/2 with invalid data returns error changeset" do
      drivers_license = drivers_license_fixture()
      assert {:error, %Ecto.Changeset{}} = License.update_drivers_license(drivers_license, @invalid_attrs)
      assert drivers_license == License.get_drivers_license!(drivers_license.id)
    end

    test "delete_drivers_license/1 deletes the drivers_license" do
      drivers_license = drivers_license_fixture()
      assert {:ok, %Drivers_license{}} = License.delete_drivers_license(drivers_license)
      assert_raise Ecto.NoResultsError, fn -> License.get_drivers_license!(drivers_license.id) end
    end

    test "change_drivers_license/1 returns a drivers_license changeset" do
      drivers_license = drivers_license_fixture()
      assert %Ecto.Changeset{} = License.change_drivers_license(drivers_license)
    end
  end
end
