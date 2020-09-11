defmodule WorkoutServer.Repo.Migrations.AddJwtToAccount do
  use Ecto.Migration

  def change do
    alter table(:account) do
      add(:jwt, :text)
    end
  end
end
