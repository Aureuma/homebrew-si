class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.54.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.54.0/si_0.54.0_darwin_arm64.tar.gz"
      sha256 "a725940b4e1483394dfd1baa7d0e4e3efb66cbb36d1ea40955dd505f3b3b7b9b"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.54.0/si_0.54.0_darwin_amd64.tar.gz"
      sha256 "56e5397a3ad7c5bb7b3a06fb5e436109a0a95310def672ab1461b54bec29255d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.54.0/si_0.54.0_linux_arm64.tar.gz"
      sha256 "606887bb8e2a815fc39c137109186da12920dafee22ff06880e4370c65520ddf"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.54.0/si_0.54.0_linux_amd64.tar.gz"
      sha256 "1899c4ef8561d783d10e75cee6ab6a5877cbfe3cb6039b20ed14884c191f26bc"
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
