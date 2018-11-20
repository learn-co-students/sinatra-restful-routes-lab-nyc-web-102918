class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes' do
  	@recipes = Recipe.all

  	erb :index
  end

	get '/recipes/new' do
  	erb :create
  end

  get '/recipes/:id' do
  	@recipe = Recipe.find(params[:id])

  	erb :show
  end

  get '/recipes/:id/edit' do
  	@recipe = Recipe.find(params[:id])

  	erb :edit
  end

  post '/recipes' do
  	recipe = Recipe.create(name: params[:name], cook_time: params[:cook_time], ingredients: params[:ingredients])

  	redirect to "/recipes/#{recipe.id}"
  end

  patch '/recipes/:id' do
  	recipe = Recipe.find(params[:id])

  	recipe.update(name: params[:name]) unless params[:name].empty?
  	recipe.update(cook_time: params[:cook_time]) unless params[:cook_time].empty?
  	recipe.update(ingredients: params[:ingredients]) unless params[:ingredients].empty?

  	recipe.save

  	redirect to "/recipes/#{recipe.id}"
  end

  delete '/recipes/:id' do
  	Recipe.find(params[:id]).destroy
  	
  	redirect to '/recipes'
  end
end
