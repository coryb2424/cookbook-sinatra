require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'

load 'models/cookbook.rb'
load 'models/recipe.rb'
set :bind, '0.0.0.0'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

cookbook = Cookbook.new('data/cookbook.csv')

get '/' do
  @recipes = cookbook.all
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  recipe = Recipe.new(params)
  cookbook.add_recipe(recipe)
  redirect '/'
end

get '/recipe/:index' do
  @index = params['index'].to_i
  @recipe = cookbook.find(@index)
  erb :recipe
end

get '/done/:index' do
  cookbook.mark_as_done(params['index'].to_i)
  redirect '/'
end

get '/delete/:index' do
  cookbook.remove_recipe(params[:index].to_i)
  redirect '/'
end

