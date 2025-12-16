ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "faker"

Dir[Rails.root.join("test/support/**/*.rb")].each { |f| require f }


module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
    include ApiMacros
    include StudentsHelper
    include SubjectHelper
    include InstructorHelper

    self.use_transactional_tests = true
  end
end
