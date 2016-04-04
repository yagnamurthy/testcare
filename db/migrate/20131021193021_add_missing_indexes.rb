class AddMissingIndexes < ActiveRecord::Migration
      def change
        add_index :offers, :contract_id
        add_index :offers, :caregiver_id
        add_index :jobs, :user_id
        add_index :journals, :user_id
        add_index :journals, :contract_id
        add_index :languages_users, [:language_code, :user_id]
        add_index :mail_receipts, :user_id
        add_index :mail_receipts, :recipient_id
        add_index :mail_receipts, :message_id
        add_index :affiliates_users, [:affiliate_id, :user_id]
        add_index :affiliates_users, [:user_id, :affiliate_id]
        add_index :allergies_users, [:allergy_id, :user_id]
        add_index :allergies_users, [:user_id, :allergy_id]
        add_index :services_users, [:service_id, :user_id]
        add_index :services_users, [:user_id, :service_id]
        add_index :questions, :user_id
        add_index :schedules, :user_id
        add_index :schools, :user_id
        add_index :contracts_services, [:contract_id, :service_id]
        add_index :contracts_services, [:service_id, :contract_id]
        add_index :tags, :user_id
        add_index :experiences, :user_id
        add_index :trainings, :user_id
        add_index :contracts, :owner_id
        add_index :credentials, :user_id
        add_index :crop_data, :user_id
        add_index :users, [:id, :type]
        add_index :contracts_users, [:contract_id, :caregiver_id]
      end
    end