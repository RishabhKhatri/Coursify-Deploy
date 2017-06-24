require "subdomain"

Rails.application.routes.draw do

  # Signup routes
  get '/signup', to: 'static#signup', constraints: {subdomain: 'accounts'}

  get '/teacher_signup', to: 'teachers#new', constraints: {subdomain: 'accounts'}

  post '/teacher_signup', to: 'teachers#create', constraints: {subdomain: 'accounts'}

  get '/student_signup', to: 'students#new', constraints: {subdomain: 'accounts'}

  post '/student_signup', to: 'students#create', constraints: {subdomain: 'accounts'}

  # Static routes
  get '/home', to: 'static#home'

  get '/about', to: 'static#about'

  get '/contact', to: 'static#contact'

  # Session routes
  get '/login', to: 'sessions#new', constraints: {subdomain: 'accounts'}

  get '/cas_login', to: 'sessions#cas_login', constraints: {subdomain: 'accounts'}

  post '/login', to: 'sessions#create', constraints: {subdomain: 'accounts'}

  get '/logout', to: 'sessions#destroy'

  get '/auth/:provider/callback', to: 'sessions#create', constraints: {subdomain: 'accounts'}

  get '/auth/failure', to: redirect('/')

  get '/teachers/edit_channel/:id', to: 'teachers#edit_channel', as: :edit_channel

  constraints(Subdomain) do
    get '/', to: 'institutes#show'
    resources :institutes
    get '/institutes/:id/teachers', to: 'institutes#teacher_index', as: 'teacher_index'
    get '/teachers/:id/remove', to: 'institutes#remove_teacher', as: 'remove_teacher'

    resources :resources, path: '/courses/:code/resources'
    resources :deadlines, path: '/courses/:code/deadlines'
  end

  get '/institutes/new', to: 'institutes#new'
  post '/institutes', to: 'institutes#create'
  get '/courses', to: 'courses#index', as: 'courses'
  post '/courses', to: 'courses#create'
  get '/courses/new', to: 'courses#new', as: 'new_course'
  get '/courses/:code/edit', to: 'courses#edit', as: 'edit_course'
  get '/courses/:code', to: 'courses#show', as: 'course'
  patch '/courses/:code', to: 'courses#update'
  put '/courses/:code', to: 'courses#update'
  delete '/courses/:code', to: 'courses#destroy'
  get '/courses/:code/archive', to: 'courses#archive', as: 'archive_course'

  resources :teachers
  resources :account_activations, only: [:edit]
  resources :students, constraints: { subdomain: 'dashboard' }
  resources :password_resets, only: [:new, :edit, :create, :update], constraints: { subdomain: 'accounts' }

  root 'static#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
