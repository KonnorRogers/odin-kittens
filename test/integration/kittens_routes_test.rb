# frozen_string_literal: true

require 'test_helper'

class KittensRoutesTest < ActionDispatch::IntegrationTest
  def setup
    @george = kittens(:george)
  end

  test 'should go through every route possible' do
    # index
    get root_url
    assert_select 'a[href=?]', root_url, count: 1
    assert_select 'a[href=?]', new_kitten_url, count: 1
  end

  test 'should create a new kitten and redirect' do
    # new, create, show
    get new_kitten_url
    assert_response :success
    assert flash.empty?

    assert_no_difference 'Kitten.count' do
      post kittens_url, params: {
        kitten: { name: 'test' }
      }
    end

    refute flash.empty?

    kitten = {
      name: 'testkitten',
      age: 10,
      softness: 5,
      cuteness: 6
    }

    assert_difference 'Kitten.count', 1 do
      post kittens_url, params: {
        kitten: kitten
      }
    end

    kitten_id = Kitten.find_by(name: kitten[:name]).id
    assert_redirected_to kitten_url(kitten_id)
    follow_redirect!
    refute flash.empty?
  end

  test 'should edit, update, then destroy the kitten' do
    # edit update destroy
    get root_url
    assert_select 'a[href=?]', edit_kitten_path(@george), count: 1
    assert_select 'a[href=?]', kitten_path(@george), count: 1, text: 'Delete'

    get edit_kitten_path(@george)
    assert_response :success

    patch kitten_path(@george), params: {
      kitten: {
        name: '' * 2,
        age: @george.age,
        softness: @george.softness,
        cuteness: @george.cuteness
      }
    }
    refute flash[:danger].empty?
    assert_select 'div#error_explanation', 1

    patch kitten_path(@george), params: {
      kitten: {
        name: @george.name,
        age: @george.age,
        softness: @george.softness,
        cuteness: @george.cuteness
      }
    }

    assert_redirected_to root_url
    follow_redirect!
    refute flash[:success].empty?
  end

  test 'should return response success for json in show and index' do
    app_json = 'application/json'
    json_headers = {
      'Accept' => app_json,
      'Content-Type' => app_json
    }
    get kitten_path(@george), headers: json_headers
    assert_response :success
    assert_match response.body, @george.to_json

    get root_url, headers: json_headers
    assert_response :success
    assert_match(response.body, Kitten.all.to_json)
  end
end
