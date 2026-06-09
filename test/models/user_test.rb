# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test 'should accept user with valid name and email' do
        assert User.new(email: 'test@example.com').valid?
        assert User.new(email: 'test@example.com', name: 'John').valid?
        assert User.new(email: 'test@example.com', name: 'Lorem Ipsum').valid?
    end

    test 'should not accept user with invalid name or email' do
        assert !User.new(email: 'test').valid?
        assert !User.new(email: 'Test', name: 'test@example.com').valid?
        assert !User.new(email: 'test@example.com', name: 'test@example.com').valid?
        assert !User.new(email: 'test@example.com', name: 'Visit https://example.com').valid?
    end

    test 'shoud accept user with valid phone' do
        assert User.new(email: 'test@example.com', phone: '+598 99 123 456').valid?
        assert User.new(email: 'test@example.com', phone: '099 123 456').valid?
        assert User.new(email: 'test@example.com', phone: '099-123-456').valid?
        assert User.new(email: 'test@example.com', phone: '2619 1234').valid?
        assert User.new(email: 'test@example.com', phone: '(+123) 2619 1234').valid?
        assert User.new(email: 'test@example.com', phone: '(123) 2619 1234').valid?
    end

    test 'shoud not accept user with invalid phone' do
        assert !User.new(email: 'test@example.com', phone: 'test').valid?
        assert !User.new(email: 'test@example.com', phone: 'test@example.com').valid?
        assert !User.new(email: 'test@example.com', phone: 'https://example.com').valid?
        assert !User.new(email: 'test@example.com', phone: '-598 123 456 123 456 123 456 123 456 123 456').valid?
    end

    test 'shoud accept user with valid company' do
        assert User.new(email: 'test@example.com', company: 'Google (Alphabet)').valid?
        assert User.new(email: 'test@example.com', company: 'Olguitech S.A.').valid?
        assert User.new(email: 'test@example.com', company: 'Google 1234').valid?
    end

    test 'shoud not accept user with invalid company' do
        assert !User.new(email: 'test@example.com', company: 'https://example.com').valid?
        assert !User.new(email: 'test@example.com', company: 'Example (https://example.com)').valid?
        assert !User.new(email: 'test@example.com',
                         company: '598 123 456 123 456 123 456 123 456 123 456 123 456 123 456 123 456 123 456 123 456')
                    .valid?
    end
end
