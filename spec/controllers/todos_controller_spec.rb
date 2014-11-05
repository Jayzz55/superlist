require 'rails_helper'
include Devise::TestHelpers

describe TodosController do
  describe '#destroy', focus: true do
    it "destroys todo" do
      @user = create(:user)
      @todo = create(:todo, user: @user)
    
      delete :destroy, id: @todo.to_param

      expect( Todo.all.count ).to eq(1)

    end
  end
end