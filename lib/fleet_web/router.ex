defmodule FleetWeb.Router do
  use FleetWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "json"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(FleetWeb.Plugs.SetUser)
    plug(FleetWeb.Plugs.SessionTimeout, timeout_after_seconds: 3000)
  end

  pipeline :session do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug :accepts, ["html", "json"]
  end

  pipeline :app do
    plug(:put_layout, {FleetWeb.LayoutView, :app})
  end

  pipeline :driver do
    plug(:put_layout, {FleetWeb.LayoutView, :driver})
  end

  pipeline :no_layout do
    plug :put_layout, false
  end

  scope "/", FleetWeb do
    pipe_through([:browser, :no_layout])

    get("/", SessionController, :new)
    post("/", SessionController, :create)
    get("/forgortFleetHub//password", UserController, :forgot_password)
    post("/confirmation/token", UserController, :token)
    get("/reset/FleetHub/password", UserController, :default_password)
    get("/logout/current/user", SessionController, :signout)
    get "/Account/Disabled", SessionController, :error_405
    get("/new/password", UserController, :new_password)
    get("/Profile", UserController, :user_profile)
  end

  scope "/", FleetWeb do
    pipe_through([:browser, :app])
    # ---------- User controller
    get "/Dashboard", UserController, :dashboard
    get "/Manage/System/Users", UserController, :user_mgt
    post  "/Create/New/FleetHub/System/User", UserController, :create_user
    get "/Edit/FleetHUB/System/User/", UserController, :edit_user
    post  "/Update/FleetHUB/System/User/", UserController, :update_user
    get "/View/User/Details", UserController, :view_user_details
    get "/Manage/License/Type", UserController, :mgt_licences
    post "/Create/License/Type", UserController, :create_license
    post "/Update/License/Type", UserController, :update_license
    get "/Manage/User/Logs", UserController, :user_logs
    post("/new/password", UserController, :change_password)
    get "/Password/Change", UserController, :user_pwd_change
    post "/User/Self/Password/Change", UserController, :pwd_self_change


    # ---------------------- Deactivated ---------------------------
    post "/Deactivate/Account", UserController, :deactivate_account
    post "/Activate/Suspended/Account", UserController, :activate_user_account

    # --------- Driver Controller
    get "/View/Driver", DriverController, :view_driver
    post "/Add/New/Driver/To/System", DriverController, :create_driver
    get "/Delete/Driver/Account", DriverController, :delete_driver
    post "/Update/Driver/Details", DriverController, :update_driver
    get "/Assign/Vehicle", DriverController, :assign_vehicle
    get "/List/of/Logged/Issues", DriverController, :logged_issues
    post "/Report/Problem/With/Vehicle", DriverController, :report_issue
    post "/File/Report", DriverController, :file_issue_report
    get "/Request/Response", DriverController, :request_response
    get "/Rejected/Request", DriverController, :rejected_request

    # --------------------------- Deactivated ----------------------------------
    post "/Deactivate/Driver/Account", DriverController, :deactivate_driver_account

    # //////////////////////////////////////////////////////////////////////// Vehicle CONTROLLER
    get "/Vehicle/management", VehicleController, :vehicle_mgt
    post "/Add/New/Vehicle/To/System", VehicleController, :create_vehicle
    get "/Vehicles/Under/Maintenance", VehicleController, :maintain_vehicle
    post "/Update/Vehicle/Details", VehicleController, :update_vehicle
    post "/Assign/Vehicle To/Driver", VehicleController, :assign_vehicle
    post "/Reassign/Vehicle/To/New/Driver", VehicleController, :reassign_vehicle

    # --------------------------------- Problem maintenance-------------------------------------
    get "/Manage/vehicle/problem", VehicleController, :mgt_problem
    post "/Create/vehicle/problem", VehicleController, :create_problem
    post "/Update/vehicle/problem", VehicleController, :update_problem


    # //////////////////////////////////////////////////////////////////////// Admin CONTROLLER
    get "/List/Contacts", AdminController, :list_vendors
    post "/Create/New/FleetHub/Contact", AdminController, :create_vendor
    get "/Delete/FleetHub/Contact", AdminController, :delete_vendor
    # get "/Edit/FleetHub/Contact", AdminController, :edit_vendor
    # post "/Update/FleetHub/Contact", AdminController, :update_vendor
    get "/GPS/Fleet/Tracking", AdminController, :fleet_tracking
    get "/Issue/Logger/Inbox", AdminController, :inbox
    get "/Resolved/Issues", AdminController, :resolved
    post "/Approve/Request", AdminController, :approve_request
    post "/Reject/Request", AdminController, :reject_request
    get "/Rejected/Issues", AdminController, :rejected

    # --------------------------- Vendors  -----------------------------------------
    post "/Update/Vendor/Contact", AdminController, :update_vendor

    # --------- Notifications Controller
    get "/email/logs", NotificationsController, :email_logs
  end

  scope "/", FleetWeb do
    pipe_through([:browser, :driver])
    get "/Home", DriverController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", FleetWeb do
  #   pipe_through :api
  # end
end
