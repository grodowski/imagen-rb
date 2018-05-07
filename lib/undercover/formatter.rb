# frozen_string_literal: true

module Undercover
  class Formatter
    def initialize(results)
      @results = results
    end

    def to_s
      return success unless @results.any?
      ([warnings_header] + formatted_warnings).join("\n")
    end

    private

    def formatted_warnings
      @results.map.with_index(1) do |res, idx|
        "🚨 #{idx}) node `#{res.node.name}` needs " \
        "test coverage! type: #{res.node.class},\n" \
        "   loc: #{res.file_path_with_lines}, " \
        "coverage: #{res.coverage_f * 100}%\n" +
          res.pretty_print
      end
    end

    def success
      "#{Rainbow('undercover').bold.lawngreen}: ✅ No coverage" \
      ' is missing in latest changes'
    end

    def warnings_header
      "#{Rainbow('undercover').bold.maroon}: " \
      '👮‍♂️ some methods have no coverage! Please add specs for methods' \
      ' listed below (or re-run the suite to refresh coverage data)'
    end
  end
end
