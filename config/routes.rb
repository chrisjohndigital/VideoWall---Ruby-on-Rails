Rails.application.routes.draw do
    root "walls#index"
    match ':controller(/:action(/:id))', :via => [:get, :post]
end
