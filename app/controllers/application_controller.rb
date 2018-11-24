class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #INDEX
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  #NEW
  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect "recipes/#{@recipe.id}"
  end


  #UPDATE part 1
  get '/recipes/:id/edit' do
    @recipe =Recipe.find(params[:id])
    erb :edit
  end

  #DELETE
  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete
    erb :delete
  end

  #UPDATE part 2
  patch '/recipes/:id' do
   @recipe = Recipe.find_by_id(params[:id])
   @recipe.name = params[:name]
   @recipe.ingredients = params[:ingredients]
   @recipe.cook_time = params[:cook_time]
   @recipe.save
   redirect to "/recipes/#{@recipe.id}"
  end

  #SHOW
  get '/recipes/:id' do
    @recipe=Recipe.find(params[:id])
    erb :show
  end




end
