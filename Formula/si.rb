class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.48.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_darwin_arm64.tar.gz"
      sha256 "389f410661ee2f4143c9f3ee87490ea508db4967fe95749cede32c10af1e9cd2"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_darwin_amd64.tar.gz"
      sha256 "4667e214521e4f200009f13e00114657ab147d87e062074399ff92d4798bace4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_linux_arm64.tar.gz"
      sha256 "97946bc864bc8809561f874f31ef3f1281b2ec4464e9041eb1f1f76a1efbbd95"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_linux_amd64.tar.gz"
      sha256 "c34791ca6a2b03c5e45712e8811282d1bbdc035c759af27775dd5097f82d742e"
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
