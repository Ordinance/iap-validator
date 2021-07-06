# frozen_string_literal: true

require 'multi_json'

module IAPValidator
  class ReceiptInfo
    # https://developer.apple.com/documentation/appstorereceipts/responsebody/receipt
    ATTRIBUTES = %i[
      adam_id app_item_id application_version bundle_id download_id expiration_date
      expiration_date_ms expiration_date_pst in_app original_application_version
      original_purchase_date original_purchase_date_ms original_purchase_date_pst
      preorder_date preorder_date_ms preorder_date_pst receipt_creation_date
      receipt_creation_date_ms receipt_creation_date_pst receipt_type request_date
      request_date_ms request_date_pst version_external_identifier
    ].freeze


    attr_reader(*ATTRIBUTES)

    def initialize(receipt:)
      adam_id = receipt['adam_id']
      app_item_id = receipt['app_item_id']
      application_version = receipt['application_version']
      bundle_id = receipt['bundle_id']
      download_id = receipt['download_id']
      expiration_date =  DateTime.parse(receipt['expiration_date']) if receipt['expiration_date']
      expiration_date_ms = Time.at(receipt['expiration_date_ms'].to_i / 1000) if receipt['expiration_date_ms']
      expiration_date_pst = receipt['expiration_date_pst']
      in_app = []
      # receipt['in_app'].each do |transaction_receipt|
      #   in_app << TransactionReceipt.new(transaction_receipt)
      # end
      original_application_version = receipt['original_application_version']
      original_purchase_date = DateTime.parse(receipt['original_purchase_date']) if receipt['original_purchase_date']
      original_purchase_date_ms = Time.at(receipt['original_purchase_date_ms'].to_i / 1000) if receipt['original_purchase_date_ms']
      original_purchase_date_pst = receipt['original_purchase_date_pst']
      preorder_date = receipt['preorder_date']
      preorder_date_ms = receipt['preorder_date_ms']
      preorder_date_pst = receipt['preorder_date_pst']
      receipt_creation_date = DateTime.parse(receipt['receipt_creation_date']) if receipt['receipt_creation_date']
      receipt_creation_date_ms = Time.at(receipt['receipt_creation_date_ms'].to_i / 1000) if receipt['receipt_creation_date_ms']
      receipt_creation_date_pst = receipt['receipt_creation_date_pst']
      receipt_type = receipt['receipt_type']
      request_date = DateTime.parse(receipt['request_date']) if receipt['request_date']
      request_date_ms = Time.at(receipt['request_date_ms'].to_i / 1000) if receipt['request_date_ms']
      request_date_pst = receipt['request_date_pst']
      version_external_identifier = receipt['version_external_identifier']
    end

    def to_hash
      {
        adam_id: adam_id,
        app_item_id: app_item_id,
        application_version: application_version,
        bundle_id: bundle_id,
        download_id: download_id,
        expiration_date: expiration_date,
        expiration_date_ms: expiration_date_ms,
        expiration_date_pst: expiration_date_pst,
        in_app: in_app,
        original_application_version: original_application_version,
        original_purchase_date: original_purchase_date,
        original_purchase_date_ms: original_purchase_date_ms,
        original_purchase_date_pst: original_purchase_date_pst,
        preorder_date: preorder_date,
        preorder_date_ms: preorder_date_ms,
        preorder_date_pst: preorder_date_pst,
        receipt_creation_date: receipt_creation_date,
        receipt_creation_date_ms: receipt_creation_date_ms,
        receipt_creation_date_pst: receipt_creation_date_pst,
        receipt_type: receipt_type,
        request_date: request_date,
        request_date_ms: request_date_ms,
        request_date_pst: request_date_pst,
        version_external_identifier: version_external_identifier,
      }
    end

    private

    attr_writer(*ATTRIBUTES)
  end
end