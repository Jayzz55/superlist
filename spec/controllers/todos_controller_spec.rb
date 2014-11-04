require 'rails_helper'
include Devise::TestHelpers

describe TodosController do
  describe '#destroy', focus: true do
    it "destroys todo" do
      @user = create(:user)
      @todo = create(:todo, user: @user)

      expect{delete :destroy_multiple, id: @todo}.to change(Todo,:count).by(-1)
    
      
    end
  end
end