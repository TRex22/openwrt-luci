require "test_helper"

class OpenwrtLuciTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil OpenwrtLuci::VERSION
  end

  def test_that_the_client_has_compatible_api_version
    assert_equal 'v1', OpenwrtLuci::Client.compatible_api_version
  end

  def test_that_the_client_has_api_version
    assert_equal 'v1 2024-05-28', OpenwrtLuci::Client.api_version
  end
end
