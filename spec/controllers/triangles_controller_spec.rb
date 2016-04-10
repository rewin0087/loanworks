require 'rails_helper'

RSpec.describe TrianglesController, :type => :controller do
  let(:triangles) { Triangle.all }

  describe 'GET index' do
    before do
      get :index
    end

    it { expect(response).to have_http_status 200 }
    it { expect(response).to render_template('layouts/application') }
    it { expect(response).to render_template('triangles/index') }
    it { expect(assigns(:triangles).to_a).to be_empty }
    it { expect(assigns(:triangles)).to be_a(ActiveRecord::Relation) }
  end

  describe 'GET new' do
    before do
      get :new
    end

    it { expect(response).to have_http_status 200 }
    it { expect(response).to render_template('layouts/application') }
    it { expect(response).to render_template('triangles/new') }
    it { expect(assigns(:triangle)).to be_a(Triangle) }
  end

  describe 'POST create' do
    context 'when success' do
      context 'when scaline' do
        before do
          post :create, triangle: { side_a: 1, side_b: 2, side_c: 3 }
        end

        it { expect(response).to have_http_status 302 }
        it { expect(response).to redirect_to root_path }
      end

      context 'when isosceles' do
        before do
          post :create, triangle: { side_a: 2, side_b: 2, side_c: 3 }
        end

        it { expect(response).to have_http_status 302 }
        it { expect(response).to redirect_to root_path }
      end

      context 'when equilateral' do
        before do
          post :create, triangle: { side_a: 3, side_b: 3, side_c: 3 }
        end

        it { expect(response).to have_http_status 302 }
        it { expect(response).to redirect_to root_path }
      end
    end

    context 'when error' do
      context 'when side_a, side_b and side_c are null' do
        before do
          post :create, triangle: { side_a: nil, side_b: nil, side_c: nil }
        end

        it { expect(response).to have_http_status 200 }
        it { expect(response).to render_template('triangles/new') }
        it { expect(assigns(:triangle).errors.size).to eql(6) }
      end

      context 'when side_a, side_b and side_c are not numeric' do
        before do
          post :create, triangle: { side_a: 'test1', side_b: 'test2', side_c: 'test3' }
        end

        it { expect(response).to have_http_status 200 }
        it { expect(response).to render_template('triangles/new') }
        it { expect(assigns(:triangle).errors.size).to eql(3) }
      end
    end
  end
end
