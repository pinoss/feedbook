require 'singleton'
require 'twitter'
require 'feedbook/errors/notifier_configuration_error'

module Feedbook
  module Notifiers
    class TwitterNotifier
      include Singleton

      # Sends notification to Twitter
      # @param message [String] message to be send to Twitter
      #
      # @return [NilClass] nil
      # @raise [Feedbook::Errors::NotifierNotifyError] if notify method fails
      def notify(message)
        if client.nil?
          puts "Message has not been notified on Twitter: #{message} because of invalid client configuration"
        else
          process_response(client.update(message))
          puts "New message has been notified on Twitter: #{message}"
        end
      rescue Twitter::Error => e
        p "TwitterNotifier did not notify because of client error (#{e.message})."
      end

      # Gets id of post after Twitter notify
      # @param provider_response after Twitter notification
      #
      # @return [String] id of message that could be used for edit post in the future
      def process_response(provider_response)
        nil
      end

      # Load configuration for TwitterNotifier
      # @param configuration = {} [Hash] Configuration hash (required: consumer_key, consumer_secret, access_token, access_token_secret)
      #
      # @return [NilClass] nil
      # @raise [Feedbook::Errors::NotifierConfigurationError] if notifier configuration fails
      def load_configuration(configuration = {})
        @client = Twitter::REST::Client.new do |config|
          config.consumer_key        = configuration.fetch('api_key')
          config.consumer_secret     = configuration.fetch('api_secret')
          config.access_token        = configuration.fetch('access_token')
          config.access_token_secret = configuration.fetch('access_token_secret')
        end

        puts 'Configuration loaded for TwitterNotifier'
      rescue Twitter::Error => e
        raise Errors::NotifierConfigurationError.new(:twitter, e.message)
      end

      private
      attr_reader :client
    end
  end
end
