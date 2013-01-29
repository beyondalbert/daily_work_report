require 'test_helper'

class MailerTest < ActionMailer::TestCase
  test "dailynote" do
    @expected.subject = 'Mailer#dailynote'
    @expected.body    = read_fixture('dailynote')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Mailer.create_dailynote(@expected.date).encoded
  end

end
