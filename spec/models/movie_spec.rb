require 'spec_helper'

describe Movie do
  it 'should get same movies' do
    Movie.should_receive(:similar_directors).with('fake Movie')
    Movie.similar_directors('fake Movie')
  end
end
