require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'アソシエーション' do
  	let(:association) do
  		described_class.reflect_on_association(target)
  	end

  	shared_examples 'belongs_to' do
  		it { expect(association.macro).to eq :belongs_to }
  	end

  	context 'article' do
  		let(:target) { :article }
  		it_behaves_like 'belongs_to'
  		it { expect(association.class_name).to eq 'Article'}
  	end
  	context 'comment' do
  		let(:target) { :comment }
  		it_behaves_like 'belongs_to'
  		it { expect(association.class_name).to eq 'Comment'}
  	end
  	context 'event' do
  		let(:target) { :event }
  		it_behaves_like 'belongs_to'
  		it { expect(association.class_name).to eq 'Event'}
  	end
  	context 'visitor' do
  		let(:target) { :visitor }
  		it_behaves_like 'belongs_to'
  		it { expect(association.class_name).to eq 'User'}
  	end
  	context 'visited' do
  		let(:target) { :visited }
  		it_behaves_like 'belongs_to'
  		it { expect(association.class_name).to eq 'User'}
  	end
  	context 'team_visitor' do
  		let(:target) { :team_visitor }
  		it_behaves_like 'belongs_to'
  		it { expect(association.class_name).to eq 'Team'}
  	end
  	context 'Team_visited' do
  		let(:target) { :team_visited }
  		it_behaves_like 'belongs_to'
  		it { expect(association.class_name).to eq 'Team'}
  	end
  end
end
