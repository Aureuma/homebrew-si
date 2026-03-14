class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.53.2"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.53.2/si_0.53.2_darwin_arm64.tar.gz"
      sha256 "338c56af90bb3cc8f47ebfda0232916fc05ab4270a4422407b7fc5eb8131fbc8"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.53.2/si_0.53.2_darwin_amd64.tar.gz"
      sha256 "d8b8c9c2d6d46b5b1231d4ef64d3b9567422c5637d4b698f5a4a267ace53a37a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.53.2/si_0.53.2_linux_arm64.tar.gz"
      sha256 "58b22f935ad4e8152e3398a6db1d5e2ca4d607b5526b41957145eb224682a132"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.53.2/si_0.53.2_linux_amd64.tar.gz"
      sha256 "128ce3df48d6be07916cfcd8eda4a8d3aa5383a497842e8b7283f5d6f113a927"
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
