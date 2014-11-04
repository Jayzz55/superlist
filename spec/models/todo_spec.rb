require 'rails_helper'

RSpec.describe Todo, :type => :model do
  describe ".delete_old_items" do
    it "wont delete any todo items less than 7 days" do

      #create 2 todo items
      now = Time.now
      Timecop.freeze(now) do
        create_list :todo, 2
      end

      #check todo items just before 7 days later
      expect(Todo.count).to eq(2)
      Timecop.freeze(now + (7.days - 1.second)) do
        Todo.delete_old_items
        expect(Todo.count).to eq(2)
      end

    end
    it "will delete any todo items more than 7 days" do

      #create 2 todo items
      now = Time.now
      Timecop.freeze(now) do
        create_list :todo, 2
      end

      #check todo items 7 days later
      expect(Todo.count).to eq(2)
      Timecop.freeze(now + 7.days) do
        Todo.delete_old_items
        expect(Todo.count).to eq(0)
      end
      
    end
  end
end
