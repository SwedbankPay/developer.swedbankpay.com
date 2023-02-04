# frozen_string_literal: true

require_relative './support/githubber'

describe 'includes used' do
  def make_relative(path)
    root_dir = File.expand_path(File.join(__dir__, '..')) + File::SEPARATOR
    path.sub(root_dir, '')
  end

  def create_pull_request_review(message, filename, line_number)
    @githubber.create_pull_request_review(message, filename, line_number)
    true
  rescue StandardError => e
    puts 'Failed to create pull request review. Falling back to regular spec failure.'
    puts e
    false
  end

  def line_should_use_include(line)
    return nil if line.include? '<!--noinclude-->'

    match = line.match(/&nbsp;`([^\|]+)`/)

    return nil unless match

    field_name = match[1]
    include_file = @fields[field_name]

    return nil unless include_file
    return nil if line.include? "{% include #{include_file}"

    [include_file, field_name]
  end

  before(:all) do
    def map_file(file_name)
      field_name = File.basename(file_name, '.md').gsub(/-[a-z]/) { |match| match[1].upcase }
      file_name = file_name.split('_includes/').last
      [ field_name, file_name ]
    end

    root_dir = File.expand_path(File.join(__dir__, '..'))
    include_dir = File.join(root_dir, '_includes')
    @fields = Dir.glob(File.join(include_dir, 'fields', '*.md')).map { |f| map_file(f) }.to_h
    @events = Dir.glob(File.join(include_dir, 'events', '*.md')).map { |f| map_file(f) }.to_h
    @files = Dir.glob(File.join(root_dir, '**', '*.md')).reject { |f| f.include?('_includes/fields') || f.include?('_includes/events') }
    @githubber = SwedbankPay::Githubber.new
  end

  context 'with fields' do
    subject { @fields }
    it { is_expected.not_to be_empty }
  end

  context 'with events' do
    subject { @events }
    it { is_expected.not_to be_empty }
  end

  context 'with GITHUB_CONTEXT' do
    subject { ENV['GITHUB_CONTEXT'] }
    it { is_expected.not_to be_empty }
  end

  context 'with files' do
    subject { @files }
    it { is_expected.not_to be_empty }

    it 'should use includes where available' do
      @files.each do |file|
        File.readlines(file).each_with_index do |line, line_number|
          (include_file, field_name) = line_should_use_include(line)
          next unless include_file

          relative_filename = make_relative(file)
          msg = "#{relative_filename}:#{line_number} should use the include '#{include_file}' for the field `#{field_name}`."

          unless create_pull_request_review(msg, relative_filename, line_number)
            expect(line).to include("{% include #{include_file}"), msg
          end
        end
      end
    end
  end
end
