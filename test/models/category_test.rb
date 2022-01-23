require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    setup do
        @category = categories(:one)
        @category2 = categories(:two)
    end

    test 'should change title language with locale' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @category.localized_title)

        I18n.locale = :en

        assert_equal('English - Lorem Ipsum', @category.localized_title)
    end

    test 'should cut title correctly' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @category.localized_short_title)

        assert_equal('123456789012345...', @category2.localized_short_title)
    end

    test 'should change desc language with locale' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @category.localized_desc
        )

        I18n.locale = :en

        assert_equal(
            'English - Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @category.localized_desc
        )
    end

    test 'should cut desc correctly' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore ...',
            @category.localized_short_desc
        )

        assert_equal(
            '1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890',
            @category2.localized_short_desc
        )
    end
end
