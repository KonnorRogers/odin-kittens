require 'test_helper'

class KittenTest < ActiveSupport::TestCase
  def setup
    @kitten = Kitten.new(name: "a" * 3,
                         age: 99,
                         cuteness: 10,
                         softness: 1)
  end

  test 'should validate' do
    assert_difference 'Kitten.count', 1 do
      @kitten.save
    end
  end

  test 'should not validate due to name' do
    assert_no_difference 'Kitten.count' do
      @kitten.name = nil
      @kitten.save
    end

    assert_no_difference 'Kitten.count' do
      @kitten.name = 'a'
      @kitten.save
    end

    assert_no_difference 'Kitten.count' do
      @kitten.name = 'a' * 21
      @kitten.save
    end
  end

  test 'should not validate due to cuteness' do
    assert_no_difference 'Kitten.count' do
      @kitten.cuteness = 'x'
      @kitten.save
    end

    assert_no_difference 'Kitten.count' do
      @kitten.cuteness = 0
      @kitten.save
    end

    assert_no_difference 'Kitten.count' do
      @kitten.cuteness = 11
      @kitten.save
    end

    assert_no_difference 'Kitten.count' do
      @kitten.cuteness = nil
      @kitten.save
    end
  end

  test 'should not validate due to softness' do
    assert_no_difference 'Kitten.count' do
      @kitten.softness = 'x'
      @kitten.save
    end

    assert_no_difference 'Kitten.count' do
      @kitten.softness = 0
      @kitten.save
    end
    assert_no_difference 'Kitten.count' do
      @kitten.softness = 11
      @kitten.save
    end

    assert_no_difference 'Kitten.count' do
      @kitten.softness = nil
      @kitten.save
    end
  end
end
