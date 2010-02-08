require 'test_helper'

class EmailerTest < ActionMailer::TestCase
  test "gmail_message" do
    @expected.subject = 'Emailer#gmail_message'
    @expected.body    = read_fixture('gmail_message')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Emailer.create_gmail_message(@expected.date).encoded
  end

end
