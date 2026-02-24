class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.49.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.49.0/si_0.49.0_darwin_arm64.tar.gz"
      sha256 "217f1b6bf4257f550fcc1d94697e9c0b8a23be64aad4accb31b05231456a30b0"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.49.0/si_0.49.0_darwin_amd64.tar.gz"
      sha256 "7fcd904eaddce3dddd281085715da3864af5da68090b1c5fa4d4a4793b511928"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.49.0/si_0.49.0_linux_arm64.tar.gz"
      sha256 "64ef139a30be12ccb7f484821a5be1b2a7f1debef9fa43c10e6797002dc17d8c"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.49.0/si_0.49.0_linux_amd64.tar.gz"
      sha256 "41963bdc3f3c6ee17832b10535b239d21b0b363bc189d680cbb2323519ec52f5"
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
