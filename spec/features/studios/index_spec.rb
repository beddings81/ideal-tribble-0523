require 'rails_helper'

RSpec.describe 'studios index page' do
  it 'contains all studio names and locations with their movies title creation year and genre' do
    disney = Studio.create!(name: "Disney", location: "Orlando")
    bet = Studio.create!(name: "BET", location: "Atlanta")
    toy_story = disney.movies.create!(title: "Toy Story", creation_year: 1995, genre: "animation")
    frozen = disney.movies.create!(title: "Frozen", creation_year: 2020, genre: "animation")
    friday = bet.movies.create!(title: "Friday", creation_year: 1996, genre: "drama")
    twenties = bet.movies.create!(title: "Twenties", creation_year: 2005, genre: "crime")

    visit "/studios"

    within("div##{disney.id}") do
      expect(page).to have_content('Disney')
      expect(page).to have_content('Title: Toy Story')
      expect(page).to have_content('Year: 1995')
      expect(page).to have_content('Genre: animation')
      expect(page).to_not have_content('Bet')
      expect(page).to_not have_content('Tilte: Friday')
      expect(page).to_not have_content('Year: 1996')
      expect(page).to_not have_content('Genre: drama')
    end
  end
end