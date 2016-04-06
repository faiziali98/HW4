require 'spec_helper'

describe MoviesController do
  describe 'finding similar movies by director' do
    before :each do
      @m = [mock("Movie"), mock("Movie")]
      @m[0].stub(:id).and_return(1)
      @m[0].stub(:director).and_return("director")
      Movie.stub(:find).and_return(@m[0])
      Movie.stub(:find_by_all_director).and_return(@m)
    end

    it 'redirect to similar_dir route' do
      { :post => movie_similar_path(1) }.
      should route_to(:controller => "movies", :action => "similar_dir", :movie_id => "1")
    end

    it 'should select the similar_dir template for rendering' do
      get :similar_dir, :movie_id => 1
      response.should render_template('similar_dir')
    end
  end
  describe 'No director info' do
    before :each do
      @m = mock("Movie")
      @m.stub(:id).and_return(1)
      @m.stub(:title).and_return("Star Wars")
      @m.stub(:director).and_return(nil)
      Movie.stub(:find).and_return(@m)
    end
    
    it 'routing to the similar_dir' do
      { :post => movie_similar_path(1) }.
      should route_to(:controller => "movies", :action => "similar_dir", :movie_id => "1")
    end
    it 'should select the index template for rendering' do
      get :similar_dir, :movie_id => 1
      response.should redirect_to(movies_path)
      flash[:notice].should_not be_blank
    end
  end
end