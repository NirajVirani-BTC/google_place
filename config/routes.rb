GooglePlace::Application.routes.draw do
  root 'places#index'
  get 'places' => 'places#search', as: 'locations'
end
