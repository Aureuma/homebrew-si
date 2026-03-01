class Si < Formula
  desc "AI-first CLI for orchestrating coding agents and provider operations"
  homepage "https://github.com/Aureuma/si"
  version "0.51.0"
  license "AGPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.51.0/si_0.51.0_darwin_arm64.tar.gz"
      sha256 "da68d460127217abcc37a7e5b896839c5bc47864f68247d3d0cbfaba2f52ec4d"
    else
      url "https://github.com/Aureuma/si/releases/download/v0.51.0/si_0.51.0_darwin_amd64.tar.gz"
      sha256 "127d76c6a61de82688cfa0c18747f60cec6b0fcd812516bc90bd8e75d9904131"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/Aureuma/si/releases/download/v0.51.0/si_0.51.0_linux_arm64.tar.gz"
      sha256 "2f8cda0c44b8c4dfe6bf8c173ef6d6435773df0d9b5648578b95d025b05be15e"
    elsif Hardware::CPU.intel?
      url "https://github.com/Aureuma/si/releases/download/v0.51.0/si_0.51.0_linux_amd64.tar.gz"
      sha256 "d4cfe949f122f3dbe8dceecae9b17d11f8a9cb71dc35f67a6c105bdcbd064026"
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
