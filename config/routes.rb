require 'api_version_constraint'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #Aula 36 (12:00 minutos) - criando o nome aqui vc terá acesso externo exemplo:
  #user
  #cliente
  #deste modo conseguiria acessar na ulr do browser passando localhost:3000/api/cliente 

    #Acesso: api.nomeDoSite.com/nomeControllerDefinidoAqui
    #Acesso Local: api.localhost:3000
  namespace :api, defaults: {format: JSON }, constraints: {subdomain: 'api'}, path: "/" do
    namespace :v1, path: "/", constraints: ApiVersionConstraint.new(version: 1, default: true) do
      #resources :tarefas
    end
  end
end