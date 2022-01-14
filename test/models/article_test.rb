require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
    setup do
        @article = articles(:one)
        @article2 = articles(:two)
    end

    test 'should change title language with locale' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @article.get_title)

        I18n.locale = :en

        assert_equal('English - Lorem Ipsum', @article.get_title)
    end

    test 'should cut title correctly' do
        I18n.locale = :es

        assert_equal('Lorem Ipsum', @article.get_short_title)

        assert_equal(
            '12345678901234567890123456789012345678901234567890...',
            @article2.get_short_title,
        )
    end

    test 'should change desc language with locale' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @article.get_desc,
        )

        I18n.locale = :en

        assert_equal(
            'English - Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
            @article.get_desc,
        )
    end

    test 'should cut desc correctly' do
        I18n.locale = :es

        assert_equal(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore ...',
            @article.get_short_desc,
        )

        assert_equal(
            '123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890',
            @article2.get_short_desc,
        )
    end

    test 'should get content and change it with locale' do
        I18n.locale = :es

        assert_equal(ActionText::RichText.find(1), @article.get_content)

        I18n.locale = :en

        assert_equal(ActionText::RichText.find(2), @article.get_content)
    end

    test 'should get uncategorized' do
        @article.update(category_ids: [])
        @article2.update(category_ids: [1])

        assert_equal([@article], Article.uncategorized)

        @article.update(category_ids: [1])
        @article2.update(category_ids: [])

        assert_equal([@article2], Article.uncategorized)
    end
end
