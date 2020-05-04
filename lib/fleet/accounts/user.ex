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
    
    belongs_to :user, Fleet.Accounts.User, foreign_key: :user_id, type: :id
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :password, :user_type, :user_role, :status, :user_id, :auto_password])
    |> validate_required([:first_name, :last_name, :email, :password, :user_type, :user_role, :status])
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

# Fleet.Accounts.create_user(%{first_name: "Luis Roy", last_name: "Zulu", email: "luis@probasegroup.com", password: "password06", user_type: 1, status: 1, user_role: "admin", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
# Fleet.Accounts.create_user(%{first_name: "John", last_name: "Doe", email: "john@doe.com", password: "password07", user_type: 2, status: 1, user_role: "dev", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})
# Fleet.Accounts.create_user(%{first_name: "Client", last_name: "Client", email: "client@info.com", password: "password08", user_type: 3, status: 1, user_role: "client", inserted_at: NaiveDateTime.utc_now, updated_at: NaiveDateTime.utc_now})

