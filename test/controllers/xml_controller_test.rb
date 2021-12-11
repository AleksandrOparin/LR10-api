# frozen_string_literal: true

require 'test_helper'

class XmlControllerTest < ActionDispatch::IntegrationTest
  test 'check rss format' do
    get '/', params: { InputNumber: 100, format: :rss }

    assert_response :success

    assert_includes @response.headers['Content-Type'], 'application/rss'
  end
end
