class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.59.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.59.0/si_0.59.0_darwin_arm64.tar.gz"
      sha256 "8fb48d4f2ad7897e0eb0605199985f1bcc628d9ab2a6419333b5cd09be7f40a6"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.59.0/si_0.59.0_darwin_amd64.tar.gz"
      sha256 "97009d4d067693d5042f7edeadd4ca549c3351913329897bff06824c7b241b6c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.59.0/si_0.59.0_linux_arm64.tar.gz"
      sha256 "fe6dcc83ddf189244cacd521794a7636efea5fb12fc48ef80ba0838409320008"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.59.0/si_0.59.0_linux_amd64.tar.gz"
      sha256 "4e7f28ef9d8b2e2d00ecf2e8425c9086386627933be6b192d45fc7e9def450fe"
    end
  end

  def install
    stage = buildpath/"si-stage"
    stage.mkpath
    system "tar", "-xzf", cached_download, "-C", stage

    binary = Dir["#{stage}/si_*/si"].first
    binary = (stage/"si").to_s if binary.nil? && (stage/"si").exist?
    raise "si binary not found in release archive" if binary.nil? || binary.empty?

    bin.install binary => "si"
    chmod 0o755, bin/"si"
  end

  test do
    output = shell_output("#{bin}/si version")
    assert_match "si version", output
  end
end
