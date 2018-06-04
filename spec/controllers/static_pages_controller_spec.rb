require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
	# 表示内容の確認用
	render_views

	let(:base_title) { 'Ruby on Rails Tutorial Sample App' }

	shared_examples_for '表示できる' do
    	it "returns http success" do
      		get target_page
      		expect(response).to have_http_status(:success)
    	end
  	end

	describe "GET #home" do

		let(:target_page) { :home }
		# Call shared_examples (l. 9-14)
    	it_behaves_like '表示できる'

    	it "should have title" do
    		#expect(response.body).to include('Ruby on Rails Tutorial')
    	end
  	end

  	describe "GET #help" do
  		let(:target_page) { :help }
    	it_behaves_like '表示できる'
  	end

  	describe "GET #about" do
  		let(:target_page) { :about }
    	it_behaves_like '表示できる'
  	end

  	describe "GET #contact" do
  		let(:target_page) { :contact }
    	it_behaves_like '表示できる'
  	end
end