class AddMovieRefToMovieActors < ActiveRecord::Migration[5.2]
  def change
    add_reference :movie_actors, :movie, foreign_key: true
  end
end
