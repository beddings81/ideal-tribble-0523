require 'rails_helper'

RSpec.describe Studio do
  describe 'relationships' do
    it {should have_many :movies}
  end

  describe '#actors' do
    it 'returns an array of unique actors' do
      disney = Studio.create!(name: "Disney", location: "Orlando")
      toy_story = disney.movies.create!(title: "Toy Story", creation_year: 1995, genre: "animation")
      toy_story2 = disney.movies.create!(title: "Toy Story 2", creation_year: 1996, genre: "animation")

      woody = toy_story.actors.create!(name: "Woody", age: 30)
      buzz = toy_story.actors.create!(name: "Buzz", age: 25)
      jessie = toy_story.actors.create!(name: "Jessie", age: 27)

      toy_story2.actors << [woody, buzz, jessie]

      expect(disney.all_actors).to eq([woody, buzz, jessie])
    end
  end
end
