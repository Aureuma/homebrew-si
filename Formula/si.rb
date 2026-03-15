class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.54.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.54.0/si_0.54.0_darwin_arm64.tar.gz"
      sha256 "62f57513d94d682758e2dd2dbd5a981329c2843daa974cb20e86ced2fe1e2c7c"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.54.0/si_0.54.0_darwin_amd64.tar.gz"
      sha256 "a3f8476319c9fc9750e15819a6296b968b369de9895bef47289a605efe031805"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.54.0/si_0.54.0_linux_arm64.tar.gz"
      sha256 "d80635eb0d1b24ee3fc0717ba730c2892d8ab8610fc7c0587786d8f7efc5b171"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.54.0/si_0.54.0_linux_amd64.tar.gz"
      sha256 "81e5a4f33f1e03e6e6db12220bdc91c5886bbfc1f44933a3cbb3102c7172da93"
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
