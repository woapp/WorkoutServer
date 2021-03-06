defmodule WorkoutServerWeb.Schema.Schema do
  use Absinthe.Schema

  alias WorkoutServerWeb.Resolvers.News
  alias WorkoutServerWeb.Resolvers.User

  object :link do
    field :id, non_null(:id)
    field :url, non_null(:string)
    field :description, non_null(:string)
  end

  object :account do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :email, non_null(:string)
  end

  object :session do
    field :jwt, non_null(:string)
  end

  query do
    @desc "Get all links"
    field :all_links, non_null(list_of(non_null(:link))) do
      resolve(&News.all_links/3)
    end

    @desc "Login with email/password"
    field :login, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&User.login/2)
    end
  end

  mutation do
    @desc "Create a new link"
    field :create_link, :link do
      arg(:url, non_null(:string))
      arg(:description, non_null(:string))

      resolve(&News.create_link/3)
    end

    @desc "Create user"
    field(:create_user, type: :account) do
      arg(:name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(&User.create_account/3)
    end

    @desc "Logout user"
    field :logout, :string do
      resolve(&WorkoutServerWeb.Resolvers.User.logout/2)
      "toto"
    end
  end
end
