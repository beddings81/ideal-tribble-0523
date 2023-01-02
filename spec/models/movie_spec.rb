require 'rails_helper'

RSpec.describe Movie do
  describe 'relationships' do
    it {should belong_to :studio}
    it {should have_many :movie_actors}
    it {should have_many :actors}
  end

   describe '#actors_ord' do
    it 'list actors from youngest to oldest' do
      disney = Studio.create!(name: "Disney", location: "Orlando")
      toy_story = disney.movies.create!(title: "Toy Story", creation_year: 1995, genre: "animation")
      woody = toy_story.actors.create!(name: "Woody", age: 30)
      buzz = toy_story.actors.create!(name: "Buzz", age: 25)
      jessie = toy_story.actors.create!(name: "Jessie", age: 27)

      expect(toy_story.actors_ord).to eq([buzz, jessie, woody])
    end
  end
end
