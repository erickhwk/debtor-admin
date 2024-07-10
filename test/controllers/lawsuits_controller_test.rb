require "test_helper"

class LawsuitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lawsuit = lawsuits(:one)
  end

  test "should get index" do
    get lawsuits_url
    assert_response :success
  end

  test "should get new" do
    get new_lawsuit_url
    assert_response :success
  end

  test "should create lawsuit" do
    assert_difference("Lawsuit.count") do
      post lawsuits_url, params: { lawsuit: { alias: @lawsuit.alias, category: @lawsuit.category, created_by_id: @lawsuit.created_by_id, tenancies_id: @lawsuit.tenancies_id } }
    end

    assert_redirected_to lawsuit_url(Lawsuit.last)
  end

  test "should show lawsuit" do
    get lawsuit_url(@lawsuit)
    assert_response :success
  end

  test "should get edit" do
    get edit_lawsuit_url(@lawsuit)
    assert_response :success
  end

  test "should update lawsuit" do
    patch lawsuit_url(@lawsuit), params: { lawsuit: { alias: @lawsuit.alias, category: @lawsuit.category, created_by_id: @lawsuit.created_by_id, tenancies_id: @lawsuit.tenancies_id } }
    assert_redirected_to lawsuit_url(@lawsuit)
  end

  test "should destroy lawsuit" do
    assert_difference("Lawsuit.count", -1) do
      delete lawsuit_url(@lawsuit)
    end

    assert_redirected_to lawsuits_url
  end
end
