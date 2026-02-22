class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.48.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_darwin_arm64.tar.gz"
      sha256 "bc8904c9b4a4d82b1349952d45171925c2b282778b616ee4ede634c3c1122e65"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_darwin_amd64.tar.gz"
      sha256 "db690dc490f155f561e6bad316c7eea922aa7773e4786a242a5eae0b035ec91f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_linux_arm64.tar.gz"
      sha256 "0a2cfaea428e3d1471e5c36aecfa68a3532d105fa523056191348acd63cbdaa8"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.48.0/si_0.48.0_linux_amd64.tar.gz"
      sha256 "41dd19c042ac75116ba58ff7b984d50341ea09d9498009be38434be3ea7efe9f"
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
