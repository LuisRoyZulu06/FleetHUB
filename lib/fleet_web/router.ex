defmodule FleetWeb.Router do
  use FleetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(FleetWeb.Plugs.SetUser)
    plug(FleetWeb.Plugs.SessionTimeout, timeout_after_seconds: 3_600)
  end

  pipeline :session do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :no_layout do
    plug :put_layout, false
  end

  scope "/", FleetWeb do
    pipe_through([:session, :no_layout])
    
    get("/", SessionController, :new)
    post("/", SessionController, :create)
    get("/forgortFleetHub//password", UserController, :forgot_password)
    post("/confirmation/token", UserController, :token)
    get("/reset/FleetHub/password", UserController, :default_password)
  end

  scope "/", FleetWeb do
    pipe_through :browser
    # --------------------------------------------- User CONTROLLER
    get "/Dashboard", UserController, :dashboard
    get "/Manage/System/Users", UserController, :user_mgt
    post  "/Create/New/FleetHub/System/User", UserController, :create_user
    get "/Edit/FleetHUB/System/User/", UserController, :edit_user
    post  "/Update/FleetHUB/System/User/", UserController, :update_user
    get "/Delete/FleetHUB/System/User/", UserController, :delete_user
    get "/Deactive/System/User/Account", UserController, :deactivate_user
    post "/Deactive/System/User/Account", UserController, :deactivate_user_account
    get "/View/Mgt/Users", UserController, :view_mgt_user
    get "/Deactivated/Driver/Accounts", UserController, :deactivated_acc
    post "/Activate/Account", UserController, :activate_user_account

    # --------------------------------------------- Driver CONTROLLER
    get "/List/FleetHub/Drivers", DriverController, :list_drivers
    get "/View/Driver", DriverController, :view_driver
    post "/Add/New/Driver/To/System", DriverController, :create_driver
    get "/Delete/Driver/Account", DriverController, :delete_driver
    post "/Update/Driver/Details", DriverController, :update_driver
    get "/Assign/Vehicle", DriverController, :assign_vehicle
    get "/List/of/Logged/Issues", DriverController, :logged_issues
    post "/Report/Problem/With/Vehicle", DriverController, :create_issue
    post "/File/Report", DriverController, :file_issue_report
    get "/Request/Response", DriverController, :request_response
    post "/Deactivate/Account", DriverController, :deactivate_account

    # --------------------------------------------- Vehicle CONTROLLER
    get "/List/FleetHub/Vehicles", VehicleController, :list_vehicles
    post "/Add/New/Vehicle/To/System", VehicleController, :create_vehicle
    get "/Vehicles/Under/Maintenance", VehicleController, :maintain_vehicle
    post "/Update/Vehicle/Details", VehicleController, :update_vehicle
    post "/Assign/Vehicle To/Driver", VehicleController, :assign_vehicle
    post "/Reassign/Vehicle/To/New/Driver", VehicleController, :reassign_vehicle

    # --------------------------------------------- Admin CONTROLLER
    get "/List/Contacts", AdminController, :list_vendors
    post "/Create/New/FleetHub/Contact", AdminController, :create_vendor
    get "/Delete/FleetHub/Contact", AdminController, :delete_vendor
    get "/Edit/FleetHub/Contact", AdminController, :edit_vendor
    post "/Update/FleetHub/Contact", AdminController, :update_vendor
    get "/GPS/Fleet/Tracking", AdminController, :fleet_tracking
    get "/Issue/Logger/Inbox", AdminController, :inbox
    get "/Resolved/Issues", AdminController, :resolved
    post "/Approve/Request", AdminController, :approve_request
    post "/Reject/Request", AdminController, :reject_request
    get "/Rejected/Issues", AdminController, :rejected
  end

  # Other scopes may use custom stacks.
  # scope "/api", FleetWeb do
  #   pipe_through :api
  # end
end
