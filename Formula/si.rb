class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.48.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_darwin_arm64.tar.gz"
      sha256 "c2397dc74f1306d0221367e661fe4f9a056817298d843c1a388713df8a1836c8"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_darwin_amd64.tar.gz"
      sha256 "6f4290d95f5c71737ae436d2ee3bb05198f34368750ac64b9930cf6a273a9d48"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_linux_arm64.tar.gz"
      sha256 "c973723797e11a215052b3424bbbbee76cff0cb5771ca15c936e633bede5c15c"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_linux_amd64.tar.gz"
      sha256 "8c6501b4a5d466df15d2fed85e439355964015da99a15ddf8b956b2fbcc09cca"
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
