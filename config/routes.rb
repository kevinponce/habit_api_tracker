Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :habits do
    resources :habit_records, only: %I[index create destroy]
  end
end
