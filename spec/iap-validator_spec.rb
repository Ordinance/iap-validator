require 'helper'
require 'multi_json'

RSpec.describe IAPValidator::Receipt do
  it 'should validate and return receipt object' do
    receipt_data     = File.read('./spec/fixtures/ios_receipt.txt')
    receipt_response = File.read('./spec/fixtures/ios_receipt.json')
    stub = stub_request(:post, IAPValidator::Client::PRODUCTION_URL)
           .with(body: { 'receipt-data' => receipt_data })
           .and_return(status: 200, body: receipt_response)

    receipt = IAPValidator::Receipt.verify(receipt_data)
    expect(receipt.status).to eq(0)
  end
end

