require 'rails_helper'


RSpec.describe Project, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  describe "instance methods" do
    before(:each) do
      @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)

      @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")

      @jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
      @gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

      ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
      ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    end

    describe "#count_contestants" do
      it 'should return the number of contestants on a given project' do
        expect(@news_chic.count_contestants).to eq(2)
      end
    end

    describe '#average_contestant_experience' do
      it 'should return the average years of experience for a given projects contestants' do
        expect(@news_chic.average_contestant_experience).to eq(12.5)
      end
    end
  end
end
