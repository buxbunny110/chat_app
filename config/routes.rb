Rails.application.routes.draw do
  root 'chatroom#index'
  post 'chatroom', to: 'chatroom#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'login', to: 'sessions#destroy'
  get 'friends', to: 'chatroom#friends'
  mount ActionCable.server, at: '/cable'
end
