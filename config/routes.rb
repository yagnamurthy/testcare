require 'sidekiq/web'

Carespotter::Application.routes.draw do

  mount Sidekiq::Web, at: '/sidekiq'

  devise_for :users, :controllers => {
    # sessions: 'sessions',
    # registration: 'registrations',
    passwords: "passwords",
    omniauth_callbacks: 'omniauth_callbacks' },
    skip: [:sessions, :registrations]


  as :user do
    get '/login' => "sessions#new", :as => :new_user_session
    post '/login' => 'sessions#create', :as => :user_session
    get '/signout' => 'sessions#destroy', :as => :destroy_user_session

    get '/users/cancel' => 'registrations#cancel', :as => :cancel_user_registration
    post '/users' => 'registrations#create', :as => :user_registration
    #get '/get_started' => 'registrations#new', :as => :new_user_registration
    get '/find_caretaker_step/reg' => 'registrations#new', :as => :new_user_registration
    get '/users/password/reset_confirmation' => 'passwords#reset_confirmation', :as => :reset_confirmation
  end

  get '/get_started' => 'find_caretaker_step#index'



  # Registration flow for Caregivers
  %w( basics about_you availability_and_services education_and_experience ).each do |code|
    get "registration/caregiver/#{code.gsub('_', '-')}" => "registration##{code}", :as => code.to_sym
  end


  get 'registration/caregiver' => 'registration#caregiver', as: 'caregiver_registration'
  get 'registration/caregiver/basics/gender' => 'registration#gender', as: 'gender'
  get 'registration/caregiver/basics/birthdate' => 'registration#birthdate', as: 'birthdate'
  get 'registration/caregiver/basics/zipcode' => 'registration#zipcode', as: 'zipcode'
  get 'registration/caregiver/basics/phone' => 'registration#phone', as: 'phone'
  get 'registration/caregiver/basics/language' => 'registration#language', as: 'language'
  get 'registration/caregiver/basics/smoking' => 'registration#smoking', as: 'smoking'
  get 'registration/caregiver/basics/allergies' => 'registration#allergies', as: 'allergies'
  get 'registration/caregiver/basics/pets' => 'registration#pets', as: 'pets'

  get 'registration/caregiver/skills-and-services/work-experience' => 'registration#work_experience', as: 'work_experience'
  get 'registration/caregiver/skills-and-services/skills' => 'registration#skills', as: 'skills'
  get 'registration/caregiver/skills-and-services/services' => 'registration#services', as: 'services'
  get 'registration/caregiver/skills-and-services/hourly_rate' => 'registration#hourly_rate', as: 'hourly_rate'
  get 'registration/caregiver/skills-and-services/live_in' => 'registration#live_in', as: 'live_in'
  get 'registration/caregiver/skills-and-services/schedule' => 'registration#schedule', as: 'schedule'
  get 'registration/caregiver/skills-and-services/credentials' => 'registration#credentials', as: 'credentials'
   get 'registration/caregiver/availability' => 'registration#availability', as: 'availability'

  get 'registration/caregiver/about/hometown' => 'registration#hometown', as: 'hometown'
  get 'registration/caregiver/about/skills' => 'registration#about_skills', as: 'about_skills'
  get 'registration/caregiver/about/me' => 'registration#me', as: 'me'
  get 'registration/caregiver/about/question-1' => 'registration#question_1', as: 'question_1'
  get 'registration/caregiver/about/question-2' => 'registration#question_2', as: 'question_2'
  get 'registration/caregiver/about/question-3' => 'registration#question_3', as: 'question_3'
  get 'registration/caregiver/about/question-4' => 'registration#question_4', as: 'question_4'
  get 'registration/caregiver/about/photo' => 'registration#photo', as: 'photo'
  get 'registration/caregiver/about/background' => 'registration#background', as: 'background'

  patch 'registration/caregiver/update' => "registration#update", :as => :update_caregiver_registration

  # Registration flow for Family
  %w( job payment ).each do |code|
    get "registration/family/#{code.gsub('_', '-')}" => "family_registration##{code}", :as => ("family_" + code).to_sym
  end

  post "registration/family/process-payment" => "family_registration#process_payment", as: :family_process_payment

  patch "registration/family/update" => "family_registration#update", :as => :update_family_registration




  resources :find_caretaker_step do
    collection do
      post :get_started
      get  :caregivers
      get  :care_needs
      get  :schedule
      get  :caretaker
      get  :submit
      get  :reg
      get  :search
      put  :update
    end
  end

  resources :users do
    resources :messages
  end

  resources :messages do
    member do
      post 'read' => 'messages#read', as: 'read'
    end
  end

  resources :caregivers do
    resources :schools, only: [:new, :create, :edit, :update, :delete]
    resources :experiences, only: [:new, :create, :edit, :update, :delete]

    resources :references

    resources :offers do
      post 'add-to-job' => 'offers#add_to_job', as: 'add_to_job'
      get 'apply-to-job' => 'offers#apply_to_job', as: 'apply_to_job'
    end

    get "photo-modal" => "users#photo_modal", :as => :photo_modal, on: :collection

    collection do
      get "edit-profile-modal" => "users#edit_profile_modal"
    end
  end

  get  "photo/modal" => "user_photos#modal"
  post "photo/upload" => "user_photos#upload"
  patch "photo/upload" => "user_photos#upload"
  post "photo/image-process" => "user_photos#image_process"

  resources :offers do
    post 'accept' => 'offers#accept'
  end

  resources :contracts do
    collection do
      post 'search'
    end


    resources :journals
    resources :contacts
    resources :todos
    resources :jobs
    resources :messages
    resources :offers

    member do
      post 'enable' => 'contracts#enable', as: :enable
      post 'disable' => 'contracts#disable', as: :disable
    end
  end

  get "searchjob/show" => "searchjob#show", :as => :searchjob_show
  get "searchjob/hirestep1" => "searchjob#hirestep1", :as => :searchjob_hirestep1
  get "searchjob/hirestep2" => "searchjob#hirestep2", :as => :searchjob_hirestep2
  get "searchjob/create1" => "searchjob#create1", :as => :searchjob_create1
  get "searchjob/create2" => "searchjob#create2", :as => :searchjob_create2



  resources :references do
    collection do
      get 'give-references' => 'references#give_references', :as => :give
    end
  end

  resources :affiliates do
    collection do
      get 'mutual' => 'affiliates#mutual', :as => :mutual
    end
  end

  post "caregivers_search" => "caregivers#search", :as => :caregiver_search

  # caregiver search page can either be near or in zipcode/city

  get "caregivers/near/:zipcode" => "caregivers#near", :as => :near
  get "caregivers/in/:zipcode" => "caregivers#near"

  scope path: "senior-caregivers", controller: 'caregivers', action: 'state_and_city_near' do
    get "/:state/:city", as: :state_and_city_near
  end

  get "dashboard" => "dashboard#show", :as => :dashboard
  get "dashboard/request_references" => "requested_references#request_references", :as => :request_references
  post "dashboard/request_references" => "requested_references#create", :as => :request_references_by_email
  get "dashboard/familyapplication" => "dashboard#familyapplication", :as => :dashboard_familyapplication

  get 'account' => 'users#edit_account', :as => :my_account

  resources :messages, :as => :mailbox, :path => 'mailbox', :only => [:show, :show, :new, :create] do
    collection do
      get 'messages/inbox' => 'messages#inbox', :as => :inbox, :path => 'inbox'
      get 'messages/sentbox' => 'messages#sentbox', :as => :sentbox, :path => 'sentbox'
      get 'messages/trash' => 'messages#trash', as: :trash, path: 'trash'
      resources :cover_letters, path: 'messages/cover-letters'
    end
  end

  get "contacts" => "contacts#show", :as => :contacts
  get "contacts/edit" => "contacts#edit", :as => :contacts_edit

  get "recommendations" => "recommendations#show", :as => :recommendations


  get 'feed' => 'feeds#show', :as => :feed



  get "dashboard/welcome_to_carespotter" => "dashboard#welcome_to_carespotter", :as => :welcome_to_carespotter

  get "add_photo_modal" => "web#add_photo_modal", :as => :add_photo_modal
  get "sign_in_modal" => "web#sign_in_modal", :as => :sign_in_modal
  get "create_job_modal" => "web#create_job_modal", :as => :create_job_modal
  get "create_job_2_modal" => "web#create_job_2_modal", :as => :create_job_2_modal
  get "new_message_modal" => "web#new_message_modal", :as => :new_message_modal
  get "apply_care_job_modal" => "web#apply_care_job_modal", :as => :apply_care_job_modal
  get "reference_request" => "web#reference_request_modal", :as => :reference_request_modal
  get "application_hire_modal" => "web#application_hire_modal", :as => :application_hire_modal
  get "application_msg_modal" => "web#application_msg_modal", :as => :application_msg_modal




  get "cannot_apply" => "web#cannot_apply", :as => :cannot_apply_modal

  get "no_caregiver" => "web#no_caregiver", as: :no_caregiver_modal



  get '/admin' => 'admin#dashboard', as: :admin_dashboard
  get '/admin/caregivers' => 'admin#caregivers', as: :admin_caregivers
  get '/admin/families' => 'admin#families', as: :admin_families
  get '/admin/contracts' => 'admin#contracts', as: :admin_contracts

  post '/admin/:model/add/:id' => 'admin#add', as: :admin_add
  post '/admin/:model/remove/:id' => 'admin#remove', as: :admin_remove
  post '/admin/caregiver/:id' => 'admin#contacted', as: :admin_contacted_caregiver
  post '/admin/contract/:id/remove' => 'admin#remove_contract', as: :admin_remove_contract

  namespace :admin do
    resources :users, only: [:edit, :update]
    resources :experiences, only: [:edit, :update]
    resources :schools, only: [:edit, :update]
    resources :contracts, only: [:edit, :update]
  end

  # if Rails.env.development?
  #   mount MailPreviewController => 'mail_view'
  # end



  # Custom error pages
  %w( 404 422 500 ).each do |code|
    get code, :to => "errors#show", :code => code, as: 'error_' + code
  end

  # Static pages for the website
  %w( show about_us how_it_works faq contact privacy terms_of_service team become_a_caregiver unsupported_browser workplace_solutions sign_up payment).each do |page|
    get "web/#{page}", path: page.gsub('_', '-')
  end

  get "/seopage" => 'static#seo'

  get "/sitemap" => 'sitemap#show'

  get "/blog", to: redirect("/blog/")

  root :to => "web#index"


end
