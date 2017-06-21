require 'spec_helper'

shared_examples 'a method that returns the percentage of objects found' do
  let(:error_number) { 1 }
  let(:success_number) { 1 }
  let(:active_error_number) { 0 }
  let(:active_success_number) { 0 }

  before do
    Document.delete_all
    error_number.times { Document.create(status: :error) }
    success_number.times { Document.create(status: :success) }
    active_error_number.times { Document.active.create(status: :error) }
    active_success_number.times { Document.active.create(status: :success) }
  end

  context 'when there are 50% documents with error' do
    it do
      expect(subject.percentage(status: :error)).to eq(0.5)
    end
  end

  context 'when there are 25% documents with error' do
    let(:success_number) { 3 }

    it do
      expect(subject.percentage(status: :error)).to eq(0.25)
    end
  end

  context 'when passing a sub scope' do
    let(:active_error_number) { 1 }
    let(:active_success_number) { 4 }

    it 'does the math inside the scope' do
      expect(Document.active.percentage(:with_error)).to eq(0.2)
    end
  end

  context 'when passing a string with SQL query' do
    it 'returns the correct percentage' do
      expect(subject.percentage("status ='error'")).to eq(0.5)
    end
  end

  context 'when passing a scope name instead of query' do
    it 'returns the correct percentage' do
      expect(subject.percentage(:with_error)).to eq(0.5)
    end
  end
end
