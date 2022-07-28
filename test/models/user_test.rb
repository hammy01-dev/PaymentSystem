require 'test_helper'
class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  # test 'invalid without name' do
  #   @user.name = nil
  #   assert_not @user.save

  # end

  test 'valid user' do
    assert @user.save
  end
  test 'invalid without email' do
    @user.email = ''
    assert_not @user.save
  end

  test 'Has right type of Image' do
    @user.image.attach(io: File.open(File.join(Rails.root, "/app/assets/images/seed/devsinc.jpg")), filename: 'devsinc.jpg')
    assert @user.valid?, 'Image should be PNG or GIF'
  end
  test 'not right type of Image' do
    @user.image.attach(io: File.open(File.join(Rails.root, "/app/assets/images/seed/test.pdf")), filename: 'test.pdf')
    assert_not @user.save
  end
  test 'image size not correct' do
    @user.image.attach(io: File.open(File.join(Rails.root, "/app/assets/images/seed/test.jpg")), filename: 'test.jpg')
    assert_not @user.valid?
  end
  test 'User should have 2 subscriptions' do
    assert_equal 2, @user.subscriptions.size

  end

end
