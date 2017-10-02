FactoryGirl.define do 
	factory :post do
		caption "bugatti"
		image Rack::Test::UploadedFile.new(Rails.root + 'spec/files/images/bugatti.jpg', 'image/jpg')
	end
end