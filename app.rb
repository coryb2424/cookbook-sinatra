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

get '/' do
  cookbook = Cookbook.new('data/cookbook.csv')
  @recipes = cookbook.all
  erb :index
end

get '/new' do
end

get '/edit/:index' do
end

get '/delete/:index' do
end
