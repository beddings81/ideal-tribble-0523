class AddActorRefToMovieActors < ActiveRecord::Migration[5.2]
  def change
    add_reference :movie_actors, :actor, foreign_key: true
  end
end
