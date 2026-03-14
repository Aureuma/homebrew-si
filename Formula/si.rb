class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.53.1"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.53.1/si_0.53.1_darwin_arm64.tar.gz"
      sha256 "d763f87783dffa3b16c581ea5675659d9e6214e286ff116f92792f1208c0847f"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.53.1/si_0.53.1_darwin_amd64.tar.gz"
      sha256 "097ad1ff8cf2bb17ea8a9e86d32e7a9e47ac75fc1543a8e490c62ab20acb0f1e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.53.1/si_0.53.1_linux_arm64.tar.gz"
      sha256 "3e9a6733c2b2affa7c7bb7a500d9eb5cc1380d357294c91859020f6a8b597aba"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.53.1/si_0.53.1_linux_amd64.tar.gz"
      sha256 "4a716ff0b9eebdc72d1f8d5f2f8a22117f6016c1b5d27c224dfd3c270894614f"
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
