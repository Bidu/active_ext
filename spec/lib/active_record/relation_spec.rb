require 'spec_helper'

describe ActiveRecord::Relation do
  describe '#percentage' do
    let(:error_number) { 1 }
    let(:success_number) { 1 }

    before do
      Document.all.each(&:destroy)
      error_number.times { Document.create(status: :error) }
      success_number.times { Document.create(status: :success) }
    end

    context 'when there are 50% documents with error' do
      it do
        expect(Document.all.percentage(status: :error)).to eq(0.5)
      end
    end

    context 'when there are 25% documents with error' do
      let(:success_number) { 3 }

      it do
        expect(Document.all.percentage(status: :error)).to eq(0.25)
      end
    end

    context 'when passing a sub scope' do
      before do
        Document.create(status: :on_going)
      end

      it 'does the math inside the scope' do
        expect(Document.where(status: [:error, :success]).percentage(status: :error)).to eq(0.5)
      end
    end

    context 'when passing a scope name instead of query' do
      it 'does the math inside the scope' do
        expect(Document.all.percentage(:with_error)).to eq(0.5)
      end
    end
  end

  describe '#pluck_as_json' do
    let(:json) { Document.all.pluck_as_json(:id, :status) }
    let(:expected) do
      [ { id: 1, status: 'error' }, { id: 2, status: 'success' } ]
    end

    before do
      Document.all.each(&:destroy)
      Document.create(id: 1, status: :error)
      Document.create(id: 2, status: :success)
    end

    it 'returns an array of hashes' do
      expect(json).to eq(expected)
    end

    context 'when no arguments are given' do
      let(:keys) do
        Document.all.pluck_as_json.first.keys
      end
      let(:expected) {%w(id status updated_at created_at)}

      it 'returns all keys' do
        expect(keys).to match_array(expected)
      end
    end
  end
end
