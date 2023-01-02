require 'rails_helper'

RSpec.describe Actor do
  describe 'relationships' do
    it {should have_many :movie_actors}
  end
end