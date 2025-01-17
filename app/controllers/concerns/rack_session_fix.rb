module RackSessionFix
  extend ActiveSupport::Concern

  class FakeRackSession < Hash
    def enabled?
      false
    end

    # Add a no-op destroy method to avoid errors
    def destroy
      # No-op: Do nothing since sessions aren't used
    end
  end

  included do
    before_action :set_fake_rack_session_for_devise

    private

    def set_fake_rack_session_for_devise
      request.env["rack.session"] ||= FakeRackSession.new
    end
  end
end
