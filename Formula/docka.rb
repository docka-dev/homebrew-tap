# Homebrew formula for Docka
# To install: brew install docka-dev/tap/docka

class Docka < Formula
  desc "Self-hosted cloud infrastructure management platform"
  homepage "https://docka.dev"
  version "0.4.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-arm64.tar.gz"
      sha256 "7fefd91f1fa815c8fad6e491a3f174d6c2952ad38dd84ca74709f9289ef8083a"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-darwin-amd64.tar.gz"
      sha256 "e8f10f7f1ad5a3d4b5c4eea2ca687846b39acd21b71e42a2fe0fa8715c53aad0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-arm64.tar.gz"
      sha256 "77dd15937f5fcd112290eca4d54be12630e6fe639b2b3bcd3ac8c1ddc70cbf91"
    end
    on_intel do
      url "https://github.com/docka-dev/docka-releases/releases/download/v#{version}/docka-linux-amd64.tar.gz"
      sha256 "d3ac004acf105e93078c74227311ea0fa0c73cfce6d247f0348858c2721a548b"
    end
  end

  def install
    bin.install "docka"
    bin.install "docka-server"
    bin.install "docka-agent" if OS.linux?
  end

  def caveats
    <<~EOS
      Docka has been installed!

      Quick start:
        docka-server          # Start the Docka server
        docka --help          # CLI commands

      Documentation: https://docka.dev/docs
    EOS
  end

  service do
    run [opt_bin/"docka-server"]
    keep_alive true
    working_dir var/"docka"
    log_path var/"log/docka.log"
    error_log_path var/"log/docka.error.log"
  end

  test do
    assert_match "docka version", shell_output("#{bin}/docka --version")
  end
end
