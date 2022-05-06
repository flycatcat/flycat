Rails.application.routes.draw do
  match "/404", to: "application#not_found", via: :all
  match "/500", to: "application#internal_server_error", via: :all
  root 'application#not_found'
end
