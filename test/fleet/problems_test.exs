defmodule Fleet.ProblemsTest do
  use Fleet.DataCase

  alias Fleet.Problems

  describe "tbl_vehicle_problems" do
    alias Fleet.Problems.Vehicle_problem

    @valid_attrs %{problem_descr: "some problem_descr"}
    @update_attrs %{problem_descr: "some updated problem_descr"}
    @invalid_attrs %{problem_descr: nil}

    def vehicle_problem_fixture(attrs \\ %{}) do
      {:ok, vehicle_problem} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Problems.create_vehicle_problem()

      vehicle_problem
    end

    test "list_tbl_vehicle_problems/0 returns all tbl_vehicle_problems" do
      vehicle_problem = vehicle_problem_fixture()
      assert Problems.list_tbl_vehicle_problems() == [vehicle_problem]
    end

    test "get_vehicle_problem!/1 returns the vehicle_problem with given id" do
      vehicle_problem = vehicle_problem_fixture()
      assert Problems.get_vehicle_problem!(vehicle_problem.id) == vehicle_problem
    end

    test "create_vehicle_problem/1 with valid data creates a vehicle_problem" do
      assert {:ok, %Vehicle_problem{} = vehicle_problem} = Problems.create_vehicle_problem(@valid_attrs)
      assert vehicle_problem.problem_descr == "some problem_descr"
    end

    test "create_vehicle_problem/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Problems.create_vehicle_problem(@invalid_attrs)
    end

    test "update_vehicle_problem/2 with valid data updates the vehicle_problem" do
      vehicle_problem = vehicle_problem_fixture()
      assert {:ok, %Vehicle_problem{} = vehicle_problem} = Problems.update_vehicle_problem(vehicle_problem, @update_attrs)
      assert vehicle_problem.problem_descr == "some updated problem_descr"
    end

    test "update_vehicle_problem/2 with invalid data returns error changeset" do
      vehicle_problem = vehicle_problem_fixture()
      assert {:error, %Ecto.Changeset{}} = Problems.update_vehicle_problem(vehicle_problem, @invalid_attrs)
      assert vehicle_problem == Problems.get_vehicle_problem!(vehicle_problem.id)
    end

    test "delete_vehicle_problem/1 deletes the vehicle_problem" do
      vehicle_problem = vehicle_problem_fixture()
      assert {:ok, %Vehicle_problem{}} = Problems.delete_vehicle_problem(vehicle_problem)
      assert_raise Ecto.NoResultsError, fn -> Problems.get_vehicle_problem!(vehicle_problem.id) end
    end

    test "change_vehicle_problem/1 returns a vehicle_problem changeset" do
      vehicle_problem = vehicle_problem_fixture()
      assert %Ecto.Changeset{} = Problems.change_vehicle_problem(vehicle_problem)
    end
  end
end
