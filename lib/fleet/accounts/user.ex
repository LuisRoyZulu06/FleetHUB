defmodule Fleet.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tbl_users" do
    field :auto_password, :string, default: "user"
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string
    field :status, :integer, default: 2
    field :user_role, :string
    field :user_type, :integer
    field :age, :integer
    field :dl_exp_dt, :string
    field :dln, :string
    field :dlt, :string
    field :home_add, :string
    field :nrc_no, :string
    field :phone, :string
    field :sex, :string
    
    
    belongs_to :user, Fleet.Accounts.User, foreign_key: :user_id, type: :id
    # belongs_to :vehicledetails, Fleet.Accounts.User, foreign_key: :driver_id, type: :id
       
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :user_type, :user_role, :status, :user_id, :auto_password, :age, :dl_exp_dt, :dln, :dlt, :home_add, :nrc_no, :phone, :sex])
    |> validate_required([:first_name, :last_name, :email, :password, :user_type, :user_role, :status, :age, :dl_exp_dt, :dln, :dlt, :home_add, :nrc_no, :phone, :sex])
    |> unique_constraint(:nrc_no, name: :unique_nrc_no, message: "Current record already exists!")
    |> unique_constraint(:phone, name: :unique_phone, message: "Current record already exists!")
    |> unique_constraint(:email, name: :unique_email, message: "Current record already exists!")
    |> unique_constraint(:dln, name: :unique_dln, message: "Current record already exists!")
    |> validate_length(:password,
      min: 4,
      max: 40,
      message: " should be atleast 4 to 40 characters"
    )
    |> validate_length(:first_name,
      min: 3,
      max: 100,
      message: "should be between 3 to 100 characters"
    )
    |> validate_length(:last_name,
      min: 3,
      max: 100,
      message: "should be between 3 to 100 characters"
    )
    |> validate_length(:email,
      min: 10,
      max: 150,
      message: "should be between 10 to 150 characters"
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

# Fleet.Accounts.create_user(%{first_name: "Luis Roy", last_name: "Zulu", email: "luis@probasegroup.com", password: "password06", user_type: 1, status: 1, user_role: "admin", age: 24, dl_exp_dt: "2020-05-07", dln: "342891101", dlt: "B", home_add: "202/20 Roma Null Off Zambezi Road", nrc_no: "342891/10/1", phone: "+260979797337", sex: "M", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
# Fleet.Accounts.create_user(%{first_name: "Meyer", last_name: "Banda", email: "meyerbanda@gmail.com", password: "password07", user_type: 2, status: 1, user_role: "driver", age: 24, dl_exp_dt: "2020-05-07", dln: "620893521", dlt: "B", home_add: "A217 Navutika Compound", nrc_no: "620893/52/1", phone: "+260976971215", sex: "F", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
# Fleet.Accounts.create_user(%{first_name: "John", last_name: "Mfula", email: "johnmfula360@gmail.com", password: "cool", user_type: 1, status: 1, user_role: "admin", age: 24, dl_exp_dt: "2020-05-07", dln: "342891101", dlt: "B", home_add: "202/20 Roma Null Off Zambezi Road", nrc_no: "342891/10/1", phone: "+260979797337", sex: "M", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})


# Fleet.Accounts.create_user(%{first_name: "Eddie", last_name: "Phiri", email: "eddie@probasegroup.com", password: "password07", user_type: 2, status: 1, user_role: "driver", age: 24, dl_exp_dt: "2020-05-07", dln: "34569812", dlt: "B", home_add: "plot23", nrc_no: "34569812/10/1", phone: "+260977097645", sex: "M", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
