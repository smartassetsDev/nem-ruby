# frozen_string_literal: true
module Nem::Util
  NEM_EPOCH = Time.utc(2015, 3, 29, 0, 6, 25, 0)

  TESTNET = 0x98000000 # -1744830464
  MAINNET = 0x68000000 #  1744830464
  MIJIN   = 0x60000000

  def self.parse_version(network, version)
    parse_network(network) | version
  end

  def self.parse_network(network)
    case network
    when :testnet then TESTNET
    when :mainnet then MAINNET
    when :mijin then MIJIN
      else TESTNET
    end
  end

  def self.parse_nemtime(nemtime)
    NEM_EPOCH + nemtime
  end

  def self.deadline(seconds = 3600)
    timestamp + seconds
  end

  def self.timestamp
    # escape FAILURE_TIMESTAMP_TOO_FAR_IN_FUTURE
    (Time.now.utc - NEM_EPOCH).to_i - 30
  end
end

Dir.glob(File.expand_path('util/*.rb', __dir__)).each { |f| require f }
