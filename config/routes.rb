Rails.application.routes.draw do

  resources :marks
  resources :disciplines
  resources :teachers
  resources :teachers
  
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}
  resources :users
  
  get 'students', to: 'students#all'
  get 'students/all', to: 'students#all'
  get 'students/:id/progress', to: 'students#progress'

  resources :students, only: [:destroy, :show, :edit, :update]

  resources :groups do
    resources :students, only: [:create, :index, :new]
    resources :lessons
    get 'timetable', on: :member
    get 'progress', on: :member
  end

  authenticated :user do
    root 'students#all', as: :authenticated_root
  end

  unauthenticated do
    root 'static_pages#home', as: :unauthenticated_root
  end

end
