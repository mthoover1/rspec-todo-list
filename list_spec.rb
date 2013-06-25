require "rspec"

require_relative "list"
require_relative "task"

describe List do
  let(:title) { "Task list" }
  
  before(:each) do
    @task_one = mock("task", :description => "task 1")
  
    @task_two = mock("task", :description => "task 2")
  end

  let(:tasks) { [@task_one, @task_two] }
  let(:list)  { List.new(title, tasks) }

  describe "#initialize" do
    it "takes a title for its first argument" do
      List.new("List for Daddy").should be_an_instance_of List
    end
    
    it "requires at least one argument" do
      expect {
        List.new
      }.to raise_error(ArgumentError)
    end

    it "requires at most two arguments" do
      expect {
        List.new("title", [], [])
      }.to raise_error(ArgumentError)
    end
  end

  describe "#add_task" do
    it "appends a task to tasks array when called" do
      list.add_task("walk the dog")
      list.tasks.length.should eq 3
    end

    it "should not add a task without an argument" do
      expect {
        list.add_task
      }.to raise_error(ArgumentError)
    end

    it "should not append an empty task" do
      list.add_task("")
      list.tasks.length.should eq 2
    end
  end

  describe "#complete_task" do
    it "should mark task at given index as complete" do
      task = list.tasks[1]
      task.stub(:complete! => true)
      list.complete_task(1).should eq true
    end

    it "should not do anything if no task at given index" do
      list.complete_task(5).should eq false
    end
  end

  describe "#delete_task" do
    it "should delete a task at a given index" do
      list.delete_task(1)
      list.tasks.length.should eq 1
    end

    it "should return false if index does not exist" do
      expect(list.delete_task(-5)).to eq(false)
    end
  end

  describe "#completed_tasks" do
    it "should return an array of tasks marked as complete" do
      @task_one.stub(:complete? => false)
      @task_two.stub(:complete? => true)
      list.completed_tasks.should eq [@task_two]
    end
  end

  describe "#incomplete_tasks" do
    it "should return an array of tasks marked as incomplete" do
      @task_one.stub(:complete? => false) 
      @task_two.stub(:complete? => true)
      list.incomplete_tasks.should eq [@task_one]
    end
  end
end
