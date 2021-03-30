defmodule Fleet.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_users" do
    field :auto_password, :string, default: "Y"
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :account_status, :string
    field :user_role, :string
    field :user_type, :integer
    field :id_type, :string
    field :nrc_no, :string
    field :drvrs_license_exp_dt, :string
    field :drvrs_license_no, :string
    field :drvrs_license_class, :string
    field :phone, :string
    field :sex, :string
    field :acc_deactive_reason, :string


    # belongs_to :user, Fleet.Accounts.User, foreign_key: :user_id, type: :id
    # belongs_to :vehicledetails, Fleet.Accounts.User, foreign_key: :driver_id, type: :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :user_type, :user_role, :account_status, :auto_password, :id_type, :nrc_no, :drvrs_license_exp_dt, :drvrs_license_no, :drvrs_license_class, :phone, :sex, :acc_deactive_reason])
    # |> validate_required([:first_name, :last_name, :email, :password, :user_type, :user_role, :account_status, :auto_password, :drvrs_license_exp_dt, :drvrs_license_no, :drvrs_license_class, :phone, :sex])
    |> unique_constraint(:drvrs_license_no, name: :unique_drvrs_license_no, message: "User with this drivers license already exists!")
    |> unique_constraint(:phone, name: :unique_phone, message: "User with this phone number already exists!")
    |> unique_constraint(:email, name: :unique_email, message: "User with this email address already exists!")
    |> unique_constraint(:nrc_no, name: :unique_nrc, message: "User with this NRC number already exists!")
    |> validate_length(:password,
      min: 6,
      max: 40,
      message: " should be atleast 6 to 40 characters"
    )
    |> validate_length(:first_name,
      min: 3,
      max: 50,
      message: "should be between 3 to 50 characters"
    )
    |> validate_length(:last_name,
      min: 3,
      max: 50,
      message: "should be between 3 to 100 characters"
    )
    |> validate_length(:email,
      min: 6,
      max: 150,
      message: "should be between 6 to 150 characters"
    )
    |> unique_constraint(:email, name: :tbl_users_email_index, message: " Email address already exists")
    |> put_pass_hash
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    Ecto.Changeset.put_change(changeset, :password, encrypt_password(password))
  end

  defp put_pass_hash(changeset), do: changeset

  def encrypt_password(password), do: Base.encode16(:crypto.hash(:sha512, password))
end

# Fleet.Accounts.create_user(%{first_name: "Luis Roy", last_name: "Zulu", email: "luis@probasegroup.com", auto_password: "Y", password: "password06", user_type: 1, account_status: "1", user_role: "ADMIN", drvrs_license_exp_dt: "2020-05-07", drvrs_license_no: "342891101", drvrs_license_class: "B", phone: "+260979797337", sex: "M", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
# Fleet.Accounts.create_user(%{first_name: "Meyer", last_name: "Banda", email: "meyerbanda@gmail.com", password: "password07", user_type: 2, status: 1, user_role: "driver", age: 24, dl_exp_dt: "2020-05-07", dln: "620893521", dlt: "B", home_add: "A217 Navutika Compound", nrc_no: "620893/52/1", phone: "+260976971215", sex: "F", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
# Fleet.Accounts.create_user(%{first_name: "John", last_name: "Mfula", email: "johnmfula360@gmail.com", password: "password07", user_type: 2, status: 1, user_role: "driver", age: 24, dl_exp_dt: "2020-05-07", dln: "987450101", dlt: "B", home_add: "90/12 Mtendere", nrc_no: "987450/10/1", phone: "+260975432237", sex: "M", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
# Fleet.Accounts.create_user(%{first_name: "Eddie", last_name: "Phiri", email: "eddie@probasegroup.com", password: "password07", user_type: 2, status: 1, user_role: "driver", age: 24, dl_exp_dt: "2020-05-07", dln: "34569812", dlt: "B", home_add: "23/90 Garden", nrc_no: "34569812/10/1", phone: "+260977097645", sex: "M", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
