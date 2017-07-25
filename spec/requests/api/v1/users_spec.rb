require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }

  before { host! 'api.taskmanager.dev' }

  # Lista usuário passando o id
  describe 'GET /users/:id' do
    before do
      headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
      get "/users/#{user_id}", params: {}, headers: headers  
    end

    context 'Quando o usuário existir: ' do
      it 'Retorno do usuário' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:id]).to eq(user_id)    
      end 
      
      it 'Retorno status de código 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'Quando o usuário não existe: ' do
      let(:user_id) { 10000 }
      
      it 'Retorno status de código 404' do
        expect(response).to have_http_status(404)
      end  
    end

  end

  # Inseri usuário
  describe 'POST /users' do
    #Antes de cada 'it' será executando a instrução dentro do 'before do ... end'
    before do
      headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
      post '/users', params: { rest_user: user_params }, headers: headers 
    end

    context 'I - Quando os parâmetros da requisição são válidos' do
      let(:user_params) { FactoryGirl.attributes_for(:user) }

      it 'I - Retorno da requisição código 201' do
        expect(response).to  have_http_status(201)
      end

      it 'I - Retorno do json data para o usuário criado' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eq(user_params[:email])
      end
    end

    context 'I - Quando os parâmetros da requisição são inválidos' do
      let(:user_params) { attributes_for(:user, email: 'invalid_email@') }

      it 'Retorno do status código 422' do
        #422 - Recebeu a requisição, porém o app não deixou salvar por alguma razão
        expect(response).to have_http_status(422)
      end

      it 'I - Retorno do json data para o erro' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end
    end
  end

  # Atualizar usuário
  describe 'PUT /users/:id' do
    before do
      headers = { 'Accept' => 'application/vnd.taskmanager.v1' }
      put "/users/#{user_id}", params: {rest_user: user_params }, headers: headers 
    end
    
    context 'U - Quando os parâmetros da requisição são válidos' do
      let(:user_params) { { email: 'new_email_malaca@gmail.com.br' } }
      
      it 'U - Retorno do status de código 200' do
        expect(response).to have_http_status(200)
      end

      it 'U - Retorno do json com os dados do usuário atualizado' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eq(user_params[:email])
      end
    end

    context 'U - Quando os parâmetros da requisição são inválidos' do
      let(:user_params) { { email: 'new_email_invalido_malaca@' } }
      
      it 'U - Retorno do status de código 422' do
        expect(response).to have_http_status(422)
      end

      it 'U - Retorno do json com os dados do usuário caso retorne erro' do
        user_response = JSON.parse(response.body, symbolize_names: true)
        expect(user_response).to have_key(:errors)
      end
    end
  end

end