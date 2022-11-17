# frozen_string_literal: true

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
    setup do
        @project = projects(:one)
        @project2 = projects(:two)
    end

    test 'should change title language with locale' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @project.localized_title)

        I18n.locale = :en

        assert_equal('English - Lorem Ipsum', @project.localized_title)
    end

    test 'should cut title correctly' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @project.localized_short_title)

        assert_equal(
            '12345678901234567890123456789012345678901234567890...',
            @project2.localized_short_title
        )
    end

    test 'should change desc language with locale' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @project.localized_desc
        )

        I18n.locale = :en

        assert_equal(
            'English - Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @project.localized_desc
        )
    end

    test 'should cut desc correctly' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ...',
            @project.localized_short_desc
        )

        assert_equal(
            '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890',
            @project2.localized_short_desc
        )
    end

    test 'should get content and change it with locale' do
        I18n.locale = :es

        assert_equal(ActionText::RichText.find(3), @project.localized_content)

        I18n.locale = :en

        assert_equal(ActionText::RichText.find(4), @project.localized_content)
    end
end
