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

    describe "validation" do
      it 'should validated todo' do
          todo = Todo.new(body: "My")
          expect(todo).to be_invalid
      end
    end

    describe ".days_left" do
      it 'should count how many days left' do
        now = Time.now
        Timecop.freeze(now) do
          @todo = create(:todo)
        end

        #check days_left counter just before 7 days later
        expect(@todo.days_left).to eq(7)
        Timecop.freeze(now + (7.days - 1.second)) do
          expect(@todo.days_left).to eq(1)
        end
      end
    end

    describe "default scope" do
      before do
        @todos = []

        @todos << create(:todo)
        @todos << create(:todo)
        @todos << create(:todo)
      end

      it 'should be correctly ordered' do
        @sorted_todos = Todo.all
        expect(@todos.first).to be == @sorted_todos.first
        expect(@todos.second).to be == @sorted_todos.second
        expect(@todos.last).to be == @sorted_todos.last
      end
    end

end

