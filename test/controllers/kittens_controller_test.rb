require 'test_helper'

class KittensControllerTest < ActionDispatch::IntegrationTest
  def setup
    @george = kittens(:george)
  end
  test 'should get root url' do
    get root_url
    assert :success
  end

  test 'should get a new kitten url' do
    get new_kitten_url
    assert :success
  end

  test 'should get show kitten url' do
    get kitten_url(@george)
    assert :success
  end

  test 'should get edit kitten url' do
    get edit_kitten_url(@george)
    assert :success
  end
end
