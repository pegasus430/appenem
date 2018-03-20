Rails.application.routes.draw do
  mount_devise_token_auth_for(
    'User',
    at: 'auth',
    skip: [:omniauth_callbacks],
    controllers: {
      sessions: 'custom_sessions'
    }
  )

  resources :origins, only: [], param: :origin_name do
    member do
      get :sign_in, format: :json
      get :sign_up
      post :register, format: :json
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    resources :schools, only: :show, param: :school_id do
      collection do
        get :search
      end
      member do
        get :overview, :evolution, :ranking, :comparison, :histogram
        resources :questions, only: [:show, :index], param: :question_id
        resources :tags, only: :index
        resources :skills, only: :index
        resources :exams, only: :index
        resources :subjects, only: :index
      end
    end
    resources :users, only: [] do
      collection do
        get :current
      end
    end
    resources :groups, param: :group_id
  end
end
