Rails.application.routes.draw do
  resources :students, only: %i[index show delete]
  resources :instructors, only: %i[index show create update destroy] do
    resources :students, only: %i[index show create update destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
