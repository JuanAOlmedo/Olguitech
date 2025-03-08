# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
    driven_by :selenium, using: :firefox, screen_size: [1400, 900]
end
