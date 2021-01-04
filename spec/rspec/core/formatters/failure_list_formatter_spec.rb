require 'rspec/core/formatters/failure_list_formatter'

module RSpec::Core::Formatters
  RSpec.describe FailureListFormatter do
    include FormatterSupport

    context 'with full backtraces disabled' do
      before do
        allow(RSpec.configuration).to receive(:full_backtrace?) { false }
      end

      it 'produces the expected full output' do
        output = run_example_specs_with_formatter('failures')
        expect(output).to eq(<<-EOS.gsub(/^\s+\|/, ''))
          |./spec/rspec/core/resources/formatter_specs.rb:4:E:Expected example to fail since it is pending, but it passed.
          |./spec/rspec/core/resources/formatter_specs.rb:37:E:expected: 2 got: 1 (compared using ==)
          |./spec/rspec/core/resources/formatter_specs.rb:41:E:expected: 2 got: 1 (compared using ==)
          |./spec/rspec/core/resources/formatter_specs.rb:42:E:expected: 4 got: 3 (compared using ==)
          |./spec/rspec/core/resources/formatter_specs.rb:50:E:foo
          |/foo.html.erb:1:E:Exception
          |./spec/rspec/core/resources/formatter_specs.rb:71:E:boom
        EOS
      end
    end

    context 'with full backtraces enabled' do
      before do
        allow(RSpec.configuration).to receive(:full_backtrace?) { true }
      end

      it 'produces the expected full output' do
        output = run_example_specs_with_formatter('failures')
        expect(output).to eq(<<-EOS.gsub(/^\s+\|/, ''))
        |./spec/rspec/core/resources/formatter_specs.rb:4:E:Expected example to fail since it is pending, but it passed.
        |./spec/rspec/core/resources/formatter_specs.rb:37:E:expected: 2 got: 1 (compared using ==)
        |./spec/support/formatter_support.rb:41:I:in `run_rspec_with_formatter'
        |./spec/support/formatter_support.rb:3:I:in `run_example_specs_with_formatter'
        |./spec/rspec/core/formatters/failure_list_formatter_spec.rb:32:I:in `block (3 levels) in <module:Formatters>'
        |./spec/support/sandboxing.rb:16:I:in `block (3 levels) in <top (required)>'
        |./spec/support/sandboxing.rb:7:I:in `block (2 levels) in <top (required)>'
        |./spec/rspec/core/resources/formatter_specs.rb:41:E:expected: 2 got: 1 (compared using ==)
        |./spec/support/formatter_support.rb:41:I:in `run_rspec_with_formatter'
        |./spec/support/formatter_support.rb:3:I:in `run_example_specs_with_formatter'
        |./spec/rspec/core/formatters/failure_list_formatter_spec.rb:32:I:in `block (3 levels) in <module:Formatters>'
        |./spec/support/sandboxing.rb:16:I:in `block (3 levels) in <top (required)>'
        |./spec/support/sandboxing.rb:7:I:in `block (2 levels) in <top (required)>'
        |./spec/rspec/core/resources/formatter_specs.rb:42:E:expected: 4 got: 3 (compared using ==)
        |./spec/support/formatter_support.rb:41:I:in `run_rspec_with_formatter'
        |./spec/support/formatter_support.rb:3:I:in `run_example_specs_with_formatter'
        |./spec/rspec/core/formatters/failure_list_formatter_spec.rb:32:I:in `block (3 levels) in <module:Formatters>'
        |./spec/support/sandboxing.rb:16:I:in `block (3 levels) in <top (required)>'
        |./spec/support/sandboxing.rb:7:I:in `block (2 levels) in <top (required)>'
        |./spec/rspec/core/resources/formatter_specs.rb:50:E:foo
        |./spec/support/formatter_support.rb:41:I:in `run_rspec_with_formatter'
        |./spec/support/formatter_support.rb:3:I:in `run_example_specs_with_formatter'
        |./spec/rspec/core/formatters/failure_list_formatter_spec.rb:32:I:in `block (3 levels) in <module:Formatters>'
        |./spec/support/sandboxing.rb:16:I:in `block (3 levels) in <top (required)>'
        |./spec/support/sandboxing.rb:7:I:in `block (2 levels) in <top (required)>'
        |/foo.html.erb:1:E:Exception
        |./spec/rspec/core/resources/formatter_specs.rb:71:E:boom
        EOS
      end
    end
  end
end
