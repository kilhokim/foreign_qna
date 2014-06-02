Gourmet::Application.routes.draw do
  # en.snu.ac.kr / my.snu.ac.kr 페이지 관련 
  get "/index" => "home#index"
  get "/en_index" => "home#en_index"
  get "/en_index_copy" => "home#en_index_copy"
  root "home#highlight"
  get "/mysnu" => "home#mysnu"
  get "/mysnu_copy" => "home#mysnu_copy"
  get "/shortcuts" => "home#shortcuts"
  get "/shortcuts_copy" => "home#shortcuts_copy"
  get "/shortcut_count" => "home#shortcuts_count"
  get "/personal" => "home#personal"
  get "/news" => "home#news"
  get "/banner" => "home#banner"
  get "/event" => "home#event"
  get "/favorite" => "home#favorite"
  get "/timetable" => "home#timetable"
  get "/maillist" => "home#maillist"
  get "/lecture" => "home#lecture"
  get "/notice" => "home#notice"

  # SNU Q&A Forum 페이지 관련
  get "users/signup"
  post "users/signup_complete"
  get "users/login"
  post "users/login_complete"
  get "users/logout_complete"
  get "/foods/posts" => 'foods#posts'
  get "/:category" => 'foods#posts_category'
  get "foods/show/:id" => 'foods#show'
  get "foods/write"
  post "foods/write_complete"
  get "foods/edit/:id" => 'foods#edit'
  post "foods/edit_complete"
  get "foods/delete_complete/:id" => 'foods#delete_complete'
	post "foods/write_comment_complete"
	get "foods/delete_comment_complete/:id" => 'foods#delete_comment_complete'

  get "foods/vote_up_complete/:id" => "foods#vote_up_complete"
  get "foods/vote_down_complete/:id" => "foods#vote_down_complete"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
