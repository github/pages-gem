# Source: https://gist.github.com/palkan/73395cc201a565ecd3ff61aac44ad5ae

module SpecProfiling
  class << self
    def init
      ruby_prof if ENV['RUBYPROF']
      stack_prof if ENV['STACKPROF']
    end

    def ruby_prof
      require 'ruby-prof'
      $stdout.puts "RubyProf enabled"

      profiler = RubyProf::Profile.new(
        merge_fibers: true,
        include_threads: [Thread.current]
      )

      profiler.start

      at_exit do
        result = profiler.stop

        # Common RSpec methods
        result.eliminate_methods!(
          [
            /instance_exec/,
            /Example(Group)?>?#run(_examples)?/,
            /Procsy/,
            /AroundHook#execute_with/,
            /HookCollections/,
            /Array#(map|each)/
          ]
        )
        printer_type = ENV['RPRINTER'] || 'call_stack'
        printer = "RubyProf::#{printer_type.camelize}Printer".constantize
        path = File.join("tmp", "ruby-prof-report-#{printer_type}-#{RubyProf.measure_mode}-total.html")
        File.open(path.to_s, 'w') { |f| printer.new(result).print(f, min_percent: 1) }
      end
    end

    def stack_prof
      require 'stackprof'
      mode = ENV['RMODE'] || 'wall'
      $stdout.puts "StackProf enabled (mode: #{mode})"
      path = File.join("tmp", "stackprof-#{mode}-test-total.dump")
      # we use raw to make it possible to generate flamegraphs
      StackProf.start(mode: mode.to_sym, raw: true)

      at_exit do
        StackProf.stop
        StackProf.results path.to_s
      end
    end
  end
end

RSpec.configure do |config|
  config.around(:each, :sprof) do |ex|
    require 'stackprof'
    mode = ENV['RMODE'] || 'wall'
    path = File.join("tmp", "stackprof-#{mode}-test-#{ex.full_description.parameterize}.dump")
    StackProf.run(mode: mode, out: path.to_s, raw: true) do
      ex.run
    end
  end

  config.around(:each, :rprof) do |ex|
    require 'ruby-prof'

    result = RubyProf.profile { ex.run }

    printer_type = ENV['RPRINTER'] || 'call_stack'
    printer = "RubyProf::#{printer_type.camelize}Printer".constantize

    path = File.join("tmp", "ruby-prof-report-#{printer_type}-#{RubyProf.measure_mode}-#{ex.full_description.parameterize}.html")
    File.open(path.to_s, 'w') { |f| printer.new(result).print(f, min_percent: 1) }
  end
end

SpecProfiling.init
