# frozen_string_literal: true

require 'test_helper'

class MessageTest < ActiveSupport::TestCase
    setup do
        @id = users(:one).id
    end

    test 'should accept messages with valid content' do
        assert Message.new(content: "Hello!, this is a question", user_id: @id).valid?
        assert Message.new(content: "Lorem ipsum", user_id: @id).valid?
    end

    test 'should not accept messages that contains links' do
        assert !Message.new(content: 'Visit https://example.com', user_id: @id).valid?
        assert !Message.new(content: 'https://example.com', user_id: @id).valid?
        assert !Message.new(content: 'Visit https://t.me/', user_id: @id).valid?
        assert !Message.new(content: 'Visit t.me/', user_id: @id).valid?
    end
end
