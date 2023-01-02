require 'rails_helper'

RSpec.describe 'movies show page' do
  it 'contains its title, creation year, and genre and list its actors from youngest to oldest' do
    disney = Studio.create!(name: "Disney", location: "Orlando")
    toy_story = disney.movies.create!(title: "Toy Story", creation_year: 1995, genre: "animation")
    frozen = disney.movies.create!(title: "Frozen", creation_year: 2020, genre: "animation")
    olaf = frozen.actors.create!(name: "Olaf", age: 15)
    woody = toy_story.actors.create!(name: "Woody", age: 30)
    buzz = toy_story.actors.create!(name: "Buzz", age: 25)
    jessie = toy_story.actors.create!(name: "Jessie", age: 27)

    visit "/movies/#{toy_story.id}"

    expect(page).to have_content("Toy Story")
    expect(page).to have_content("Year: 1995")
    expect(page).to have_content("Genre: animation")

    within('div#actors') do
      expect(page).to have_content("Woody")
      expect(page).to have_content("Buzz")
      expect(page).to have_content("Jessie")
      expect(page).to_not have_content("Olaf")
      expect("Buzz").to appear_before("Jessie")
      expect("Jessie").to appear_before("Woody")
      expect("Jessie").to_not appear_before("Buzz")
      expect("Woody").to_not appear_before("Buzz")
    end
  end

  it 'contains a form to add an existing actor to the movie' do
    disney = Studio.create!(name: "Disney", location: "Orlando")
    toy_story = disney.movies.create!(title: "Toy Story", creation_year: 1995, genre: "animation")
    woody = Actor.create!(name: "Woody", age: 30)


    visit "/movies/#{toy_story.id}"

    within('div#actors') do
      expect(page).to_not have_content("woody")
    end

    expect(page).to have_field('actor_id')
    fill_in('actor_id', with: "#{woody.id}")
    
    click_button("Submit")
    
    expect(current_path).to eq("/movies/#{toy_story.id}")
    
    within('div#actors') do
      expect(page).to have_content("Woody")
    end
  end
end