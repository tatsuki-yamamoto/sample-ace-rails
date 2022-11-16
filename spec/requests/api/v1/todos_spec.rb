require 'rails_helper'
require 'rspec_openapi_helper'

RSpec.describe '/api/v1/todos', type: :request do
  let(:valid_attributes) do
    {
      title: 'title',
      description: 'description'
    }
  end

  describe 'GET /index' do
    context '正常系' do
      it '正しいデータが返却されること' do
        Todo.create! valid_attributes
        get '/api/v1/todos', as: :json
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /show' do
    context '正常系' do
      it '正しいデータが返却されること' do
        todo = Todo.create! valid_attributes
        get "/api/v1/todos/#{todo.id}", as: :json
        expect(response).to be_successful
      end
    end
  end

  describe 'POST /create' do
    context '正常系' do
      it '200が返却されること' do
        post '/api/v1/todos', params: { todo: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'データが作成されること' do
        expect do
          post '/api/v1/todos', params: { todo: valid_attributes }, as: :json
        end.to change(Todo, :count).by(1)
      end
    end
  end

  describe 'PATCH /update' do
    context '正常系' do
      let(:new_attributes) do
        {
          title: '更新'
        }
      end

      it '200が返却されること' do
        todo = Todo.create! valid_attributes
        patch "/api/v1/todos/#{todo.id}", params: { todo: new_attributes }, as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'データが更新されること' do
        todo = Todo.create! valid_attributes
        patch "/api/v1/todos/#{todo.id}", params: { todo: new_attributes }, as: :json
        json = JSON.parse(response.body)
        expect(json['name']).to eq(new_attributes[:name])
      end
    end
  end

  describe 'DELETE /destroy' do
    context '正常系' do
      it '200が返却されること' do
        todo = Todo.create! valid_attributes
        delete "/api/v1/todos/#{todo.id}", as: :json
        expect(response).to have_http_status(:ok)
      end

      it 'データが削除されること' do
        todo = Todo.create! valid_attributes
        expect do
          delete "/api/v1/todos/#{todo.id}", as: :json
        end.to change(Todo, :count).by(-1)
      end
    end

    context '異常系' do
      it '404が返却されること' do
        delete '/api/v1/todos/999999', as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
