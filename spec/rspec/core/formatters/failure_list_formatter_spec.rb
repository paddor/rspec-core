require 'rspec/core/formatters/failure_list_formatter'

module RSpec::Core::Formatters
  RSpec.describe FailureListFormatter do
    include FormatterSupport

    it 'produces the expected full output', skip: RSpec::Support::Ruby.jruby? && !(RSpec::Support::Ruby.jruby_9000? && RSpec::Support::Ruby.jruby_version >= '9.2.0.0') do
      output = run_example_specs_with_formatter('failures')
      output.gsub!(/`.*?'$/, "`...'") # JRuby dumps block nesting slightly differently
      expect(output).to eq(<<-EOS.gsub(/^\s+\|/, ''))
        |./spec/rspec/core/resources/formatter_specs.rb:4:E:Expected example to fail since it is pending, but it passed.
        |./spec/rspec/core/resources/formatter_specs.rb:37:E:expected: 2 got: 1 (compared using ==)
        |./spec/rspec/core/resources/formatter_specs.rb:37:I:in `...'
        |./spec/support/formatter_support.rb:41:I:in `...'
        |./spec/support/formatter_support.rb:3:I:in `...'
        |./spec/rspec/core/formatters/failure_list_formatter_spec.rb:8:I:in `...'
        |./spec/support/sandboxing.rb:16:I:in `...'
        |./spec/support/sandboxing.rb:7:I:in `...'
        |./spec/rspec/core/resources/formatter_specs.rb:41:E:expected: 2 got: 1 (compared using ==)
        |./spec/rspec/core/resources/formatter_specs.rb:41:I:in `...'
        |./spec/support/formatter_support.rb:41:I:in `...'
        |./spec/support/formatter_support.rb:3:I:in `...'
        |./spec/rspec/core/formatters/failure_list_formatter_spec.rb:8:I:in `...'
        |./spec/support/sandboxing.rb:16:I:in `...'
        |./spec/support/sandboxing.rb:7:I:in `...'
        |./spec/rspec/core/resources/formatter_specs.rb:42:E:expected: 4 got: 3 (compared using ==)
        |./spec/rspec/core/resources/formatter_specs.rb:42:I:in `...'
        |./spec/support/formatter_support.rb:41:I:in `...'
        |./spec/support/formatter_support.rb:3:I:in `...'
        |./spec/rspec/core/formatters/failure_list_formatter_spec.rb:8:I:in `...'
        |./spec/support/sandboxing.rb:16:I:in `...'
        |./spec/support/sandboxing.rb:7:I:in `...'
        |./spec/rspec/core/resources/formatter_specs.rb:50:E:foo
        |./spec/rspec/core/resources/formatter_specs.rb:50:I:in `...'
        |./spec/support/formatter_support.rb:41:I:in `...'
        |./spec/support/formatter_support.rb:3:I:in `...'
        |./spec/rspec/core/formatters/failure_list_formatter_spec.rb:8:I:in `...'
        |./spec/support/sandboxing.rb:16:I:in `...'
        |./spec/support/sandboxing.rb:7:I:in `...'
        |/foo.html.erb:1:E:Exception
        |/foo.html.erb:1:I:in `<main>': foo (RuntimeError)
        |./spec/rspec/core/resources/formatter_specs.rb:71:E:boom
      EOS
    end
  end
end
