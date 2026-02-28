class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.50.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.50.0/si_0.50.0_darwin_arm64.tar.gz"
      sha256 "93000bb847090c32905bab0ec10848e5678b82d9e7ae172243d3b2ef9c9722c8"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.50.0/si_0.50.0_darwin_amd64.tar.gz"
      sha256 "cc3fecdf8bb228271d62de48a8d58588d1724a2a7652139c8ace5d5ad69608f3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.50.0/si_0.50.0_linux_arm64.tar.gz"
      sha256 "69a8b69f44916633371a2bd2b2d9b2d6678fa8ba6f904c996d7d1f8cd5d0a972"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.50.0/si_0.50.0_linux_amd64.tar.gz"
      sha256 "f765e154d48558eadc13cad9fd071bcf26fee33a4306a03e9130fa2f38435159"
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
