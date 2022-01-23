require 'test_helper'

class ProductTest < ActiveSupport::TestCase
    setup do
        @product = products(:one)
        @product2 = products(:two)
    end

    test 'should change title language with locale' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @product.localized_title)

        I18n.locale = :en

        assert_equal('English - Lorem Ipsum', @product.localized_title)
    end

    test 'should cut title correctly' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @product.localized_short_title)

        assert_equal(
            '12345678901234567890123456789012345678901234567890...',
            @product2.localized_short_title
        )
    end

    test 'should change desc language with locale' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @product.localized_desc
        )

        I18n.locale = :en

        assert_equal(
            'English - Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @product.localized_desc
        )
    end

    test 'should cut desc correctly' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ...',
            @product.localized_short_desc
        )

        assert_equal(
            '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890',
            @product2.localized_short_desc
        )
    end

    test 'should get content and change it with locale' do
        I18n.locale = :es

        assert_equal(ActionText::RichText.find(5), @product.localized_content)

        I18n.locale = :en

        assert_equal(ActionText::RichText.find(6), @product.localized_content)
    end

    test 'should get uncategorized' do
        @product.update(category_ids: [])
        @product2.update(category_ids: [1])

        assert_equal([@product], Product.uncategorized)

        @product.update(category_ids: [1])
        @product2.update(category_ids: [])

        assert_equal([@product2], Product.uncategorized)
    end
end
