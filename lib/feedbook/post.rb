module Feedbook
  class Post
    attr_accessor :message_id
    attr_reader :author, :published, :url, :title, :feed_title

    # Initializes new Post from opts Hash
    # @param opts = {} [Hash] Hash with params required for Post creation
    #
    # @return [NilClass] nil
    def initialize(opts = {})
      @author     = opts.fetch(:author)
      @published  = opts.fetch(:published)
      @url        = opts.fetch(:url)
      @title      = opts.fetch(:title)
      @feed_title = opts.fetch(:feed_title)
      @message_id = opts.fetch(:message_id, nil)
    end

    # Returns hash with values from posts.
    #
    # @return [Hash] Hash with post variables
    def to_hash
      {
        'author'     => author,
        'published'  => published,
        'url'        => url,
        'title'      => title,
        'feed_title' => feed_title,
        'message_id' => message_id
      }
    end
    alias :to_h :to_hash
  end
end
