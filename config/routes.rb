Rails.application.routes.draw do
  resources :artists
  resources :artworks
  post 'artworks/images', to: 'image_files#upload'
end
