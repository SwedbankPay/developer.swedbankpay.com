# frozen_string_literal: true

require_relative 'support/verifier'
require_relative 'support/safe_strip'

Verifier = ::SwedbankPay::Verifier

describe Verifier do
  let(:dir) { File.expand_path(File.join(__dir__, '..', '_site')) }
  let(:auth_token) { ENV['GITHUB_TOKEN'].safe_strip }

  it 'has a GITHUB_TOKEN' do
    expect(auth_token).not_to be_nil
    expect(auth_token).not_to be_empty
  end

  it 'verifies the built site' do
    verifier = Verifier.new(auth_token, log_level: :warn)
    result = nil

    begin
      verifier.verify(dir)
    rescue SystemExit => e
      result = e
    end

    expect(result).to be_nil
  end

  context 'index.html' do
    subject { File.read(File.join(dir, 'index.html')) }

    it { is_expected.to include('https://developer.swedbankpay.com/') }
    it { is_expected.to include('src="/assets/') }
  end
end
