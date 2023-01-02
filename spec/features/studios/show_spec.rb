require 'rails_helper'

RSpec.describe 'studios show page' do
  it 'contains a studios name and location' do
    disney = Studio.create!(name: "Disney", location: "Orlando")
    toy_story = disney.movies.create!(title: "Toy Story", creation_year: 1995, genre: "animation")
    frozen = disney.movies.create!(title: "Frozen", creation_year: 2020, genre: "animation")
    olaf = frozen.actors.create!(name: "Olaf", age: 15)
    woody = toy_story.actors.create!(name: "Woody", age: 30)
    buzz = toy_story.actors.create!(name: "Buzz", age: 25)
    jessie = toy_story.actors.create!(name: "Jessie", age: 27)

    visit "/studios/#{disney.id}"

    expect(page).to have_content("Disney")
    expect(page).to have_content("Location: Orlando")
  end

  it 'contains a unique list of actors that have worked on this studios movies' do
    disney = Studio.create!(name: "Disney", location: "Orlando")
    toy_story = disney.movies.create!(title: "Toy Story", creation_year: 1995, genre: "animation")
    toy_story2 = disney.movies.create!(title: "Toy Story 2", creation_year: 1996, genre: "animation")

    woody = toy_story.actors.create!(name: "Woody", age: 30)
    buzz = toy_story.actors.create!(name: "Buzz", age: 25)
    jessie = toy_story.actors.create!(name: "Jessie", age: 27)

    toy_story2.actors << [woody, buzz, jessie]

    visit "/studios/#{disney.id}"
    
    expect(page).to have_content('Woody').once
    expect(page).to have_content('Buzz').once
    expect(page).to have_content('Jessie').once
    save_and_open_page
  end
end