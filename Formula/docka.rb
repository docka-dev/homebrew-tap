# Homebrew formula for Docka
# To install: brew install docka-dev/tap/docka

class Docka < Formula
  desc "Self-hosted cloud infrastructure management platform"
  homepage "https://docka.dev"
  version "0.1.49"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-arm64.tar.gz"
      sha256 "cb0f99824fae247b33f207487aebf276ba81562d609db10c383e102a5651bdc0"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-amd64.tar.gz"
      sha256 "65b5140e251f37fe55bef7a3d7819df735cfe1892d716310d0cd311f4e406235"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-arm64.tar.gz"
      sha256 "b4869244bd3b2966960193856c3c70564686c26b3bfbb2298b27a698334901a4"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-amd64.tar.gz"
      sha256 "1bab997b2f803c87905abbb3e37b10ff4b9d529f1d4304ae6e9ff1c837443298"
    end
  end

  def install
    bin.install "docka"
    bin.install "docka-server"
    bin.install "docka-agent"
  end

  def caveats
    <<~EOS
      Docka has been installed!

      Quick start:
        docka serve           # Start the Docka server
        docka --help          # CLI commands

      Documentation: https://docka.dev/docs
    EOS
  end

  service do
    run [opt_bin/"docka", "serve"]
    keep_alive true
    working_dir var/"docka"
    log_path var/"log/docka.log"
    error_log_path var/"log/docka.error.log"
  end

  test do
    assert_match "docka version", shell_output("#{bin}/docka --version")
  end
end